import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../providers/app_providers.dart';
import '../../models/models.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activitiesProvider = context.watch<ActivitiesProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('الأنشطة والفعاليات'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
              IconButton(onPressed: () => activitiesProvider.fetchActivities(), icon: const Icon(CupertinoIcons.refresh)),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  FilterChip(label: const Text('الكل'), selected: true, onSelected: (b) {}),
                  const SizedBox(width: 8),
                  FilterChip(label: const Text('هاكاثون'), selected: false, onSelected: (b) {}),
                  const SizedBox(width: 8),
                  FilterChip(label: const Text('ورش عمل'), selected: false, onSelected: (b) {}),
                  const SizedBox(width: 8),
                  FilterChip(label: const Text('معارض'), selected: false, onSelected: (b) {}),
                ],
              ),
            ),
          ),
          if (activitiesProvider.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (activitiesProvider.activities.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('لا توجد أنشطة حالياً')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final activity = activitiesProvider.activities[index];
                    return _buildM3ActivityCard(context, activity);
                  },
                  childCount: activitiesProvider.activities.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildM3ActivityCard(BuildContext context, Activity activity) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Color categoryColor;
    IconData categoryIcon;
    
    switch (activity.category) {
      case 'هاكاثون':
        categoryColor = colorScheme.primary;
        categoryIcon = CupertinoIcons.bolt_fill;
        break;
      case 'معارض':
        categoryColor = colorScheme.secondary;
        categoryIcon = CupertinoIcons.briefcase_fill;
        break;
      default:
        categoryColor = colorScheme.tertiary;
        categoryIcon = CupertinoIcons.lightbulb_fill;
    }

    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: categoryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(categoryIcon, color: categoryColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(activity.committee, style: TextStyle(color: colorScheme.primary, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(activity.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(CupertinoIcons.calendar, size: 14),
                    const SizedBox(width: 4),
                    Text(activity.date, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                activity.isRegistered 
                  ? Chip(label: const Text('مسجل', style: TextStyle(fontSize: 12)), backgroundColor: colorScheme.primaryContainer)
                  : TextButton(onPressed: () {}, child: const Text('سجل الآن')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
