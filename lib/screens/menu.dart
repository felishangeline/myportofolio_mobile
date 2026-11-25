import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506656740';
  final String nama = 'Felisha Angeline';
  final String kelas = 'PBP D';

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    final items = <ItemHomepage>[
      const ItemHomepage('Lihat Proyek', Icons.folder_open, Color(0xFFD8C3A5)),
      const ItemHomepage(
        'Tambah Proyek',
        Icons.add_circle_outline,
        Color(0xFF6F4E37),
      ),
      const ItemHomepage(
        'Tambah Edukasi',
        Icons.school_outlined,
        Color(0xFFA47551),
      ),
      if (isLoggedIn)
        const ItemHomepage('Logout', Icons.logout, Color(0xFF6F4E37))
      else
        const ItemHomepage('Login', Icons.login, Color(0xFF6F4E37)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: InfoCard(title: 'NPM', content: npm),
              ),
              Expanded(
                child: InfoCard(title: 'Name', content: nama),
              ),
              Expanded(
                child: InfoCard(title: 'Class', content: kelas),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Selamat datang di MyPortfolio Mobile!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Pilih aksi untuk mengelola portofoliomu.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: items.map((item) => ItemCard(item)).toList(),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(content, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
