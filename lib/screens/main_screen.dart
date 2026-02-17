import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home/home_screen.dart';
import 'activities/activities_screen.dart';
import 'tasks/tasks_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ActivitiesScreen(),
    TasksScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('إرسال ملاحظات'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('شكراً لاستخدامك النسخة التجريبية!'),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'اكتب ملاحظتك هنا...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                FilledButton(onPressed: () => Navigator.pop(context), child: const Text('إرسال')),
              ],
            ),
          );
        },
        label: const Text('ملاحظات النسخة'),
        icon: const Icon(CupertinoIcons.ant_fill),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(CupertinoIcons.home),
            selectedIcon: Icon(CupertinoIcons.house_fill),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.calendar),
            selectedIcon: Icon(CupertinoIcons.calendar_badge_plus),
            label: 'الأنشطة',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.checkmark_square),
            selectedIcon: Icon(CupertinoIcons.checkmark_square_fill),
            label: 'المهام',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.settings),
            selectedIcon: Icon(CupertinoIcons.settings_solid),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}
