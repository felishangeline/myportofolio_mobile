import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

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

          if (item.name == 'Lihat Proyek') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProjectListScreen(),
              ),
            );
          } else if (item.name == 'Tambah Proyek') {
            ensureLoggedIn(context).then((loggedIn) {
              if (!loggedIn || !context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            });
          } else if (item.name == 'Logout' &&
              context.read<AuthState>().isLoggedIn) {
            context.read<AuthState>().logout();
          } else if (item.name == 'Login') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
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
