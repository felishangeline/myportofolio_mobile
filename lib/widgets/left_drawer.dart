import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'MyPortfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Menu navigasi aplikasi',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah Proyek'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Tambah Edukasi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const EducationFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
