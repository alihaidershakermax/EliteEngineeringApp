import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('الأرشيف والوسائط')),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
        children: [
          _buildArchiveCard(context, 'صور الفعاليات', '45 صورة', CupertinoIcons.photo_on_rectangle, colorScheme.primary),
          _buildArchiveCard(context, 'التقارير السنوية', '12 ملف', CupertinoIcons.doc_text_fill, colorScheme.secondary),
          _buildArchiveCard(context, 'فيديوهات الندوات', '8 فيديو', CupertinoIcons.play_rectangle_fill, colorScheme.tertiary),
          _buildArchiveCard(context, 'شهادات الحضور', '25 شهادة', CupertinoIcons.rosette, colorScheme.error),
        ],
      ),
    );
  }

  Widget _buildArchiveCard(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: color.withOpacity(0.1))),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(height: 12),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(fontSize: 12, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
