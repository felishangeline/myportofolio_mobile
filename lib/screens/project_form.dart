import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _techStack = TextEditingController();
  final _projectUrl = TextEditingController();
  final _imageUrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _techStack.dispose();
    _projectUrl.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label wajib diisi.' : null;

  String? _url(String? value, {bool optional = false}) {
    final text = value?.trim() ?? '';
    if (optional && text.isEmpty) return null;
    final uri = Uri.tryParse(text);
    if (uri == null ||
        !uri.hasScheme ||
        uri.host.isEmpty ||
        !['http', 'https'].contains(uri.scheme)) {
      return 'Masukkan URL yang valid (http atau https).';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;
    setState(() => _saving = true);
    try {
      await context.read<ApiClient>().createProject(
        Project(
          title: _title.text.trim(),
          description: _description.text.trim(),
          techStack: _techStack.text.trim(),
          projectUrl: _projectUrl.text.trim(),
          projectImageUrl: _imageUrl.text.trim(),
        ),
        token: token,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan'),
          content: const Text('Data proyek sudah tersimpan di server.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (mounted) await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan proyek (HTTP ${error.statusCode}).'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  InputDecoration _decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Tambah Proyek')),
    drawer: const LeftDrawer(),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _title,
            decoration: _decoration('Title'),
            validator: (value) => _required(value, 'Title'),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _description,
            maxLines: 4,
            decoration: _decoration('Description'),
            validator: (value) => _required(value, 'Description'),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _techStack,
            decoration: _decoration('Tech Stack'),
            validator: (value) => _required(value, 'Tech Stack'),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _projectUrl,
            keyboardType: TextInputType.url,
            decoration: _decoration('Project URL'),
            validator: _url,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _imageUrl,
            keyboardType: TextInputType.url,
            decoration: _decoration('Project Image URL (Optional)'),
            validator: (value) => _url(value, optional: true),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving ? null : _submit,
            icon: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: const Text('Simpan'),
          ),
        ],
      ),
    ),
  );
}
