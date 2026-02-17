import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'providers/app_providers.dart';

class EliteEngineeringApp extends StatelessWidget {
  const EliteEngineeringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..fetchProfile()),
        ChangeNotifierProvider(create: (_) => ActivitiesProvider()..fetchActivities()),
        ChangeNotifierProvider(create: (_) => TasksProvider()..fetchTasks()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Elite Engineering Gathering',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF728156),
            brightness: Brightness.light,
          ),
          fontFamily: 'Cairo',
        ),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: MainScreen(),
        ),
      ),
    );
  }
}
