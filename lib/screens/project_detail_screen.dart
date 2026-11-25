import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});
  final Project project;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(project.title)),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (project.projectImageUrl.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              project.projectImageUrl,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Text('Tech stack', style: Theme.of(context).textTheme.titleMedium),
        Text(project.techStack),
        const SizedBox(height: 12),
        Text('Description', style: Theme.of(context).textTheme.titleMedium),
        Text(project.description),
        if (project.projectUrl.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Project URL', style: Theme.of(context).textTheme.titleMedium),
          SelectableText(project.projectUrl),
        ],
      ],
    ),
  );
}
