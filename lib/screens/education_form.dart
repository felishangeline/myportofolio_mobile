import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _programController = TextEditingController();
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();

  @override
  void dispose() {
    _institutionController.dispose();
    _programController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi.';
    }
    if (value.trim().length < 2) {
      return '$fieldName minimal terdiri dari 2 karakter.';
    }
    return null;
  }

  String? _yearValidator(String? value, {bool optional = false}) {
    final yearText = value?.trim() ?? '';
    if (optional && yearText.isEmpty) return null;
    if (yearText.isEmpty) return 'Tahun mulai wajib diisi.';
    if (yearText.length != 4 || int.tryParse(yearText) == null) {
      return 'Masukkan tahun dengan 4 angka.';
    }

    final year = int.parse(yearText);
    final currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear + 10) {
      return 'Tahun harus antara 1950 dan ${currentYear + 10}.';
    }

    if (optional) {
      final startYear = int.tryParse(_startYearController.text.trim());
      if (startYear != null && year < startYear) {
        return 'Tahun selesai tidak boleh sebelum tahun mulai.';
      }
    }
    return null;
  }

  void _showEducationSummary() {
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ringkasan Edukasi'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Institusi: ${_institutionController.text.trim()}'),
              const SizedBox(height: 8),
              Text('Program/Gelar: ${_programController.text.trim()}'),
              const SizedBox(height: 8),
              Text('Tahun Mulai: ${_startYearController.text.trim()}'),
              const SizedBox(height: 8),
              Text(
                'Tahun Selesai: ${_endYearController.text.trim().isEmpty ? 'Masih berlangsung' : _endYearController.text.trim()}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Edukasi')),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 24 + bottomInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _institutionController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    'Nama Institusi',
                    hint: 'Contoh: Universitas Indonesia',
                  ),
                  validator: (value) =>
                      _requiredValidator(value, 'Nama institusi'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _programController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    'Program atau Gelar',
                    hint: 'Contoh: Ilmu Komputer',
                  ),
                  validator: (value) =>
                      _requiredValidator(value, 'Program atau gelar'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _startYearController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Tahun Mulai'),
                  validator: _yearValidator,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _endYearController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration(
                    'Tahun Selesai (opsional)',
                    hint: 'Kosongkan jika masih berlangsung',
                  ),
                  validator: (value) => _yearValidator(value, optional: true),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _showEducationSummary,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    );
  }
}
