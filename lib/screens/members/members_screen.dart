import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('أعضاء اللجنة'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
              IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.person_add)),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildM3MemberCard(context, 'سارة أحمد محمد', 'رئيسة لجنة التنظيم', 92, colorScheme.primary, 'SA'),
                _buildM3MemberCard(context, 'محمد خالد العتيبي', 'منسق الأنشطة', 85, colorScheme.secondary, 'MK'),
                _buildM3MemberCard(context, 'نورة عبدالله السالم', 'مسؤولة الإعلام', 78, colorScheme.tertiary, 'NA'),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.person_add_solid),
                  label: const Text('إضافة عضو جديد'),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildM3MemberCard(BuildContext context, String name, String role, int participation, Color color, String initials) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.1),
          child: Text(initials, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(role, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: participation / 100,
                minHeight: 4,
                backgroundColor: colorScheme.outlineVariant,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
