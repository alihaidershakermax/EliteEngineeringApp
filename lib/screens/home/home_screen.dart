import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../announcements/announcements_screen.dart';
import '../archive/archive_screen.dart';
import '../members/members_screen.dart';
import '../activities/activities_screen.dart';
import '../../providers/app_providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Row(
              children: [
                const Text('النخبة الهندسية'),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'تجريبية',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AnnouncementsScreen())),
                icon: const Icon(CupertinoIcons.bell_fill),
              ),
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ArchiveScreen())),
                icon: const Icon(CupertinoIcons.archivebox_fill),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userProvider.isLoading 
                    ? const LinearProgressIndicator()
                    : Text(
                        'مرحباً بك، ${userProvider.user?.name ?? 'مهندس'} 👋', 
                        style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)
                      ),
                  const SizedBox(height: 24),
                  
                  _buildQuickActions(context, colorScheme),
                  const SizedBox(height: 32),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('آخر الأخبار', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () {}, child: const Text('عرض الكل')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildNewsCarousel(context, colorScheme),
                  
                  const SizedBox(height: 32),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('فعاليات قادمة', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ActivitiesScreen())), child: const Text('الأجندة')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildEventCard(context, 'ندوة الذكاء الاصطناعي في الهندسة', '15 فبراير • 08:00 ص', 'فندق هيلتون، الرياض', colorScheme.primaryContainer),
                  _buildEventCard(context, 'مؤتمر الاستدامة العمرانية', '22 فبراير • 10:00 ص', 'مركز الابتكار، جدة', colorScheme.secondaryContainer),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(CupertinoIcons.person_2_fill, 'الأعضاء', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MembersScreen()))),
          _buildActionItem(CupertinoIcons.doc_text_fill, 'التقارير', () {}),
          _buildActionItem(CupertinoIcons.app_badge_fill, 'الطلبات', () {}),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNewsCarousel(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        children: [
          _buildNewsItem(context, 'تحديثات الكود السعودي 2024', 'أخبار تقنية', colorScheme.surfaceVariant),
          _buildNewsItem(context, 'هاكاثون الطاقة المتجددة', 'فعالية', colorScheme.secondaryContainer),
        ],
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, String title, String tag, Color color) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(left: 16),
      child: Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(10)), child: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
              const Spacer(),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              const Row(children: [Text('اقرأ المزيد', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Icon(CupertinoIcons.arrow_left, size: 14)]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, String title, String time, String location, Color color) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          children: [
            const SizedBox(height: 8),
            Row(children: [const Icon(CupertinoIcons.clock, size: 14), const SizedBox(width: 4), Text(time)]),
            Row(children: [const Icon(CupertinoIcons.location, size: 14), const SizedBox(width: 4), Text(location)]),
          ],
        ),
        trailing: const Icon(CupertinoIcons.chevron_left),
      ),
    );
  }
}
