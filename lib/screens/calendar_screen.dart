import 'package:flutter/material.dart';
import '../widgets/studytrack_bottom_nav.dart';
import 'task_details_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const Color background = Color(0xFFF8F9FE);
  static const Color navy = Color(0xFF11183F);
  static const Color secondary = Color(0xFF7B86A8);
  static const Color purple = Color(0xFF6048F5);
  static const Color lightPurple = Color(0xFFF1EEFF);

  DateTime currentMonth = DateTime(2026, 8);
  DateTime selectedDate = DateTime(2026, 8, 15);

  final List<DateTime> deadlines = [
    DateTime(2026, 8, 12),
    DateTime(2026, 8, 15),
    DateTime(2026, 8, 24),
  ];

  final List<String> months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void _navigate(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/tasks');
    } else if (index == 2) {
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  bool _sameDate(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  bool _hasDeadline(DateTime date) {
    return deadlines.any((d) => _sameDate(d, date));
  }

  List<Widget> _calendarCells() {
    final first = DateTime(
      currentMonth.year,
      currentMonth.month,
      1,
    );

    final last = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );

    final List<Widget> widgets = [];

    for (int i = 1; i < first.weekday; i++) {
      widgets.add(const SizedBox());
    }

    for (int day = 1; day <= last.day; day++) {
      final date = DateTime(
        currentMonth.year,
        currentMonth.month,
        day,
      );

      final selected = _sameDate(date, selectedDate);
      final deadline = _hasDeadline(date);

      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 31,
                height: 31,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? purple
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: selected ? Colors.white : navy,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              if (deadline)
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: purple,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 5),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  void _openUxTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TaskDetailsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final august =
        currentMonth.year == 2026 &&
        currentMonth.month == 8;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 25),
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
                        Text(
                          'Calendar',
                          style: TextStyle(
                            color: navy,
                            fontSize: 33,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Track your deadlines',
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

              const SizedBox(height: 20),

              Container(
                height: 51,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentMonth = DateTime(
                            currentMonth.year,
                            currentMonth.month - 1,
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${months[currentMonth.month - 1]} ${currentMonth.year}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: navy,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentMonth = DateTime(
                            currentMonth.year,
                            currentMonth.month + 1,
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.chevron_right_rounded,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 7,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        _DayHeading('Mon'),
                        _DayHeading('Tue'),
                        _DayHeading('Wed'),
                        _DayHeading('Thu'),
                        _DayHeading('Fri'),
                        _DayHeading('Sat'),
                        _DayHeading('Sun'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1),
                    const SizedBox(height: 7),
                    GridView.count(
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.95,
                      children: _calendarCells(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Upcoming Deadlines',
                style: TextStyle(
                  color: navy,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              if (august) ...[
                GestureDetector(
                  onTap: _openUxTask,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      13,
                      16,
                      13,
                      12,
                    ),
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 49,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.insert_drive_file_outlined,
                                color: purple,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 11),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'UX Prototype Assignment',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ICT725',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Due: 15 August',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          children: [
                            Text(
                              '70%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.70,
                                minHeight: 7,
                                color: Colors.white,
                                backgroundColor: Colors.white30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TaskDetailsScreen(
                          title: 'Database Quiz',
                          priority: 'Medium',
                          initialProgress: 0.20,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.storage_rounded,
                          color: purple,
                          size: 34,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                              Text(
                                'Due: 15 August',
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: purple,
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Text(
                      'No deadlines for this month',
                      style: TextStyle(color: secondary),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StudyTrackBottomNav(
        currentIndex: 2,
        onTap: _navigate,
      ),
    );
  }
}

class _DayHeading extends StatelessWidget {
  final String text;

  const _DayHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _CalendarScreenState.secondary,
          fontSize: 12,
        ),
      ),
    );
  }
}