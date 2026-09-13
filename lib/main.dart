import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/task_details_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const StudyTrackApp());
}

class StudyTrackApp extends StatelessWidget {
  const StudyTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6048F5),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/task-details': (context) => const TaskDetailsScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}