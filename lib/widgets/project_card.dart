import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(item.color) == Brightness.dark
        ? Colors.white
        : Colors.brown.shade900;

    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
              ),
            );

          if (item.name == 'Tambah Proyek') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          } else if (item.name == 'Tambah Edukasi') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const EducationFormPage(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: foregroundColor, size: 32),
              const SizedBox(height: 8),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
