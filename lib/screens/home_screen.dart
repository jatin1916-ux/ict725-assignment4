import 'package:flutter/material.dart';
import '../widgets/studytrack_bottom_nav.dart';
import 'task_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const Color background = Color(0xFFF8F9FE);
  static const Color navy = Color(0xFF11183F);
  static const Color secondary = Color(0xFF7B86A8);
  static const Color purple = Color(0xFF6048F5);
  static const Color lightPurple = Color(0xFFF0EDFF);
  static const Color green = Color(0xFF08B894);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigate(int index) {
    if (index == 0) return;

    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/tasks');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/calendar');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  void _openTask(
    String title,
    String dueDate,
    double progress, {
    String priority = 'High',
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskDetailsScreen(
          title: title,
          subject: 'ICT725',
          dueDate: dueDate,
          initialProgress: progress,
          priority: priority,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hi, Alex',
                              style: TextStyle(
                                color: navy,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                height: 1.05,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              '👋',
                              style: TextStyle(fontSize: 27),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ready to study?',
                          style: TextStyle(
                            color: secondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 9,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search tasks, subjects...',
                    hintStyle: TextStyle(
                      color: Color(0xFF8B8B92),
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 31,
                      color: Color(0xFF828282),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 23),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Upcoming Tasks',
                      style: TextStyle(
                        color: Color(0xFF050D83),
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/tasks',
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        'View all >',
                        style: TextStyle(
                          color: Color(0xFFAA009B),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 13),

              GestureDetector(
                onTap: () => _openTask(
                  'UX Prototype Assignment',
                  '15 August 2026',
                  0.70,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    13,
                    18,
                    13,
                    13,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF684FFF),
                        Color(0xFF5947E9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 51,
                            height: 51,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Icon(
                              Icons.insert_drive_file_outlined,
                              color: purple,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 11),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UX Prototype Assignment',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    height: 1.18,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'ICT725',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Due: 15 August',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            '70%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: const LinearProgressIndicator(
                                value: 0.70,
                                minHeight: 7,
                                backgroundColor: Colors.white30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              GestureDetector(
                onTap: () => _openTask(
                  'Database Quiz',
                  '15 August 2026',
                  0.20,
                  priority: 'Medium',
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 6,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.storage_rounded,
                          color: purple,
                          size: 29,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Database Quiz',
                              style: TextStyle(
                                color: navy,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'ICT725',
                              style: TextStyle(
                                color: secondary,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: secondary,
                                  size: 17,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Due: 15 August',
                                  style: TextStyle(
                                    color: secondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 37,
                        height: 37,
                        decoration: const BoxDecoration(
                          color: lightPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: purple,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Row(
                children: [
                  Expanded(
                    child: _HomeStatCard(
                      number: '3',
                      label: 'Tasks due\nthis week',
                      icon: Icons.assignment_outlined,
                      accent: purple,
                      iconBackground: lightPurple,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _HomeStatCard(
                      number: '2',
                      label: 'Completed\nthis week',
                      icon: Icons.check_circle_outline_rounded,
                      accent: green,
                      iconBackground: Color(0xFFE4F8F2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StudyTrackBottomNav(
        currentIndex: 0,
        onTap: _navigate,
      ),
    );
  }
}

class _HomeStatCard extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;
  final Color accent;
  final Color iconBackground;

  const _HomeStatCard({
    required this.number,
    required this.label,
    required this.icon,
    required this.accent,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 92,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: accent,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: accent,
                    fontSize: 23,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 2,
                  style: const TextStyle(
                    color: _HomeScreenState.navy,
                    fontSize: 12,
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}