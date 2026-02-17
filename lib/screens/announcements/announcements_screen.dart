import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعلانات'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('عامة'), icon: Icon(CupertinoIcons.globe)),
                ButtonSegment(value: 1, label: Text('خاصة'), icon: Icon(CupertinoIcons.lock_fill)),
              ],
              selected: {_selectedTab},
              onSelectionChanged: (newVal) => setState(() => _selectedTab = newVal.first),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _selectedTab == 0
            ? [
                _buildAnnouncementCard(
                  context,
                  'تحديث لائحة الأنشطة الطلابية',
                  'يرجى من جميع الطلاب مراجعة اللائحة الجديدة قبل 20 فبراير',
                  '15 فبراير 2026',
                  colorScheme.primary,
                  CupertinoIcons.doc_text,
                  true,
                ),
                const SizedBox(height: 16),
                _buildAnnouncementCard(
                  context,
                  'فتح باب التسجيل للهاكاثون',
                  'سجل الآن في هاكاثون الطاقة المستدامة - الفرص محدودة!',
                  '14 فبراير 2026',
                  colorScheme.secondary,
                  CupertinoIcons.bolt_fill,
                  false,
                ),
              ]
            : [
                _buildAnnouncementCard(
                  context,
                  'تهنئة بمناسبة التخرج',
                  'نبارك للزملاء الخريجين في قسم الهندسة الكهربائية',
                  '12 فبراير 2026',
                  colorScheme.tertiary,
                  CupertinoIcons.sparkles,
                  false,
                ),
              ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, String title, String description, String date, Color color, IconData icon, bool isPinned) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: color.withOpacity(0.1))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 20)),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                if (isPinned) const Icon(CupertinoIcons.pin_fill, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text(date, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant))]),
          ],
        ),
      ),
    );
  }
}
