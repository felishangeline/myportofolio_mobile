import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _projectName = '';
  String _description = '';
  String _category = 'Web Development';
  String _technologies = '';
  String _projectLink = '';

  final List<String> _categories = const [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _projectName = '';
      _description = '';
      _category = _categories.first;
      _technologies = '';
      _projectLink = '';
    });
  }

  void _showProjectSummary() {
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Proyek berhasil ditambahkan!'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama Proyek: $_projectName'),
              const SizedBox(height: 8),
              Text('Deskripsi: $_description'),
              const SizedBox(height: 8),
              Text('Kategori: $_category'),
              const SizedBox(height: 8),
              Text(
                'Teknologi: ${_technologies.trim().isEmpty ? '-' : _technologies}',
              ),
              const SizedBox(height: 8),
              Text(
                'Tautan: ${_projectLink.trim().isEmpty ? '-' : _projectLink}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _resetForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Proyek')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: _inputDecoration('Nama Proyek'),
                  onChanged: (value) => _projectName = value,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama proyek tidak boleh kosong!'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 5,
                  decoration: _inputDecoration('Deskripsi Proyek'),
                  onChanged: (value) => _description = value,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Deskripsi proyek tidak boleh kosong!'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kategori Proyek',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: _inputDecoration(
                    'Teknologi yang Digunakan',
                    hint: 'Contoh: Flutter, Django, Figma',
                  ),
                  onChanged: (value) => _technologies = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: _inputDecoration(
                    'Tautan Proyek',
                    hint: 'URL Proyek (opsional)',
                  ),
                  onChanged: (value) => _projectLink = value,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _showProjectSummary,
                    child: const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      hintText: hint ?? label,
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    );
  }
}
