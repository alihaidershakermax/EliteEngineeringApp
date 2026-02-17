import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../providers/app_providers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isNotificationOn = true;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('الملف الشخصي', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [colorScheme.primaryContainer, colorScheme.surface],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  userProvider.isLoading 
                    ? const Center(child: CircularProgressIndicator())
                    : _buildProfileHeader(colorScheme, textTheme, user?.name ?? 'بدون اسم', user?.position ?? 'مهندس'),
                  const SizedBox(height: 32),
                  _buildStatsRow(colorScheme),
                  const SizedBox(height: 32),
                  _buildSectionDivider('النسخة التجريبية (Beta)'),
                  _buildSettingsGroup([
                    _buildTile(context, CupertinoIcons.info_circle_fill, 'إصدار التجربة', 'Alpha v1.0.1 (Dynamic)'),
                    _buildTile(context, CupertinoIcons.ant, 'سجل الأخطاء المعروفة', 'تم رصد 2 أخطاء طفيفة'),
                    _buildTile(context, CupertinoIcons.chat_bubble_2_fill, 'تواصل مع المطورين', 'ارسل ملاحظاتك مباشرة'),
                  ]),

                  const SizedBox(height: 24),
                  _buildSectionDivider('إعدادات الحساب'),
                  _buildSettingsGroup([
                    _buildTile(context, CupertinoIcons.person_fill, 'تعديل البيانات الشخصية', user?.email ?? 'البريد الإلكتروني'),
                    _buildTile(context, CupertinoIcons.lock_shield_fill, 'الأمان والخصوصية', 'كلمة المرور، رقم الجوال'),
                    _buildTile(context, CupertinoIcons.doc_text_fill, 'الشهادات والوثائق', 'تحميل شهادات الحضور والخبرة'),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionDivider('تفضيلات التطبيق'),
                  _buildSettingsGroup([
                    _buildSwitchTile(context, CupertinoIcons.bell_fill, 'الإشعارات الذكية', 'تنبيهات الفعاليات والمهام', _isNotificationOn, (v) => setState(() => _isNotificationOn = v)),
                    _buildSwitchTile(context, CupertinoIcons.moon_stars_fill, 'الوضع الليلي', 'مظهر مريح للعين', _isDarkMode, (v) => setState(() => _isDarkMode = v)),
                    _buildTile(context, CupertinoIcons.globe, 'لغة التطبيق', 'العربية (السعودية)'),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionDivider('الدعم والتواصل'),
                  _buildSettingsGroup([
                    _buildTile(context, CupertinoIcons.question_circle_fill, 'مركز المساعدة', 'الأسئلة الشائعة'),
                    _buildTile(context, CupertinoIcons.phone_fill, 'اتصل بنا', 'دعم فني 24/7'),
                  ]),
                  const SizedBox(height: 40),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: colorScheme.error, minimumSize: const Size(double.infinity, 56)),
                    icon: const Icon(CupertinoIcons.square_arrow_right),
                    label: const Text('تسجيل الخروج', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ColorScheme colorScheme, TextTheme textTheme, String name, String position) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: colorScheme.primary,
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: const Color(0xFFE7F5DC),
                  child: Text(name[0], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF728156))),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
              child: const Icon(CupertinoIcons.camera_fill, size: 16, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(name, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(position, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildStatsRow(ColorScheme colorScheme) {
    return Row(
      children: [
        _buildStatCard('12', 'مهمة منجزة', colorScheme.primary),
        const SizedBox(width: 12),
        _buildStatCard('5', 'فعاليات', colorScheme.secondary),
        const SizedBox(width: 12),
        _buildStatCard('A+', 'التقييم', colorScheme.tertiary),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.1))),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDivider(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: Align(alignment: Alignment.centerRight, child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey))),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: Color(0xFFF0F0F0))),
      child: Column(children: children),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(CupertinoIcons.chevron_left, size: 14),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(BuildContext context, IconData icon, String title, String subtitle, bool val, Function(bool) onChanged) {
    return SwitchListTile.adaptive(
      value: val,
      onChanged: onChanged,
      secondary: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    );
  }
}
