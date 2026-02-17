import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../providers/app_providers.dart';
import '../../models/models.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tasksProvider = context.watch<TasksProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('المهام والمتابعة'),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add_circled, color: colorScheme.primary)),
              IconButton(onPressed: () => tasksProvider.fetchTasks(), icon: const Icon(CupertinoIcons.refresh)),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildM3TaskStat(context, '${tasksProvider.tasks.where((t) => !t.isCompleted).length}', 'نشطة', colorScheme.primary, CupertinoIcons.clock),
                  const SizedBox(width: 12),
                  _buildM3TaskStat(context, '${tasksProvider.tasks.where((t) => t.isCompleted).length}', 'مكتملة', colorScheme.secondary, CupertinoIcons.checkmark_circle),
                  const SizedBox(width: 12),
                  _buildM3TaskStat(context, '0', 'متأخرة', colorScheme.error, CupertinoIcons.exclamationmark_triangle),
                ],
              ),
            ),
          ),
          if (tasksProvider.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (tasksProvider.tasks.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('لا توجد مهام حالياً')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = tasksProvider.tasks[index];
                    return _buildM3TaskCard(context, task);
                  },
                  childCount: tasksProvider.tasks.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildM3TaskStat(BuildContext context, String val, String label, Color color, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: color.withOpacity(0.1))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              Text(val, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color)),
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildM3TaskCard(BuildContext context, Task task) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Color priorityColor = Colors.grey;
    if (task.priority == 'عالية') priorityColor = colorScheme.error;
    if (task.priority == 'متوسطة') priorityColor = colorScheme.primary;
    if (task.priority == 'منخفضة') priorityColor = colorScheme.secondary;

    return Card(
      elevation: 0,
      color: task.isCompleted ? colorScheme.surface : colorScheme.surfaceVariant.withOpacity(0.2),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), 
        side: BorderSide(color: task.isCompleted ? priorityColor.withOpacity(0.5) : colorScheme.outlineVariant)
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Checkbox(
          value: task.isCompleted, 
          onChanged: (v) {}, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
        ),
        title: Text(
          task.title, 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            decoration: task.isCompleted ? TextDecoration.lineThrough : null, 
            color: task.isCompleted ? colorScheme.onSurfaceVariant : colorScheme.onSurface
          )
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                _buildPriorityChip(context, task.priority, priorityColor),
                const SizedBox(width: 12),
                Icon(CupertinoIcons.clock, size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(task.dueTime, style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 12),
            if (!task.isCompleted)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: task.progress / 100, 
                  minHeight: 6, 
                  backgroundColor: colorScheme.outlineVariant, 
                  valueColor: AlwaysStoppedAnimation<Color>(priorityColor)
                ),
              ),
          ],
        ),
        trailing: CircleAvatar(
          radius: 14, 
          backgroundColor: colorScheme.primaryContainer, 
          child: Text(task.assignee[0], style: TextStyle(fontSize: 10, color: colorScheme.onPrimaryContainer))
        ),
      ),
    );
  }

  Widget _buildPriorityChip(BuildContext context, String priority, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withOpacity(0.2))),
      child: Text(priority, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
