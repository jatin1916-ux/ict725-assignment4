import 'package:flutter/material.dart';
import '../widgets/studytrack_bottom_nav.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String title;
  final String subject;
  final String dueDate;
  final double initialProgress;
  final String priority;

  const TaskDetailsScreen({
    super.key,
    this.title = 'UX Prototype Assignment',
    this.subject = 'ICT725',
    this.dueDate = '15 August 2026',
    this.initialProgress = 0.70,
    this.priority = 'High',
  });

  @override
  State<TaskDetailsScreen> createState() =>
      _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  static const Color background = Color(0xFFF8F9FE);
  static const Color navy = Color(0xFF11183F);
  static const Color secondary = Color(0xFF7B86A8);
  static const Color purple = Color(0xFF6048F5);
  static const Color lightPurple = Color(0xFFF1EEFF);
  static const Color pink = Color(0xFFFF5F8A);
  static const Color green = Color(0xFF08B894);

  bool wireframes = true;
  bool highFidelity = false;
  bool prototype = false;
  bool complete = false;

  int get completedCount {
    int total = 0;

    if (wireframes) total++;
    if (highFidelity) total++;
    if (prototype) total++;

    return total;
  }

  double get progress {
    if (complete || completedCount == 3) return 1.0;

    if (completedCount == 2) return 0.85;

    if (completedCount == 1) {
      return widget.initialProgress;
    }

    return 0.0;
  }

  void _navigate(int index) {
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    } else if (index == 1) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/tasks',
        (route) => false,
      );
    } else if (index == 2) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/calendar',
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/profile',
        (route) => false,
      );
    }
  }

  void _back() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/tasks');
    }
  }

  void _markComplete() {
    setState(() {
      complete = !complete;

      if (complete) {
        wireframes = true;
        highFidelity = true;
        prototype = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          complete
              ? 'Task marked as complete'
              : 'Task marked as incomplete',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 25),
          child: Column(
            children: [
              Row(
                children: [
                  _roundButton(
                    Icons.chevron_left_rounded,
                    _back,
                  ),
                  const Expanded(
                    child: Text(
                      'Task Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: navy,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _roundButton(
                    Icons.more_horiz_rounded,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('More task options'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 21),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  17,
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
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.insert_drive_file_outlined,
                            color: purple,
                            size: 31,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                widget.subject,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
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

                    const SizedBox(height: 21),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _summary(
                            'Due Date',
                            widget.dueDate,
                            Icons.calendar_today_outlined,
                          ),
                        ),
                        Container(
                          height: 46,
                          width: 1,
                          color: Colors.white24,
                        ),
                        Expanded(
                          child: _summary(
                            'Priority',
                            widget.priority,
                            Icons.check_box_outlined,
                          ),
                        ),
                        Container(
                          height: 46,
                          width: 1,
                          color: Colors.white24,
                        ),
                        Expanded(
                          child: _summary(
                            'Progress',
                            '$percent%',
                            Icons.radio_button_unchecked_rounded,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Text(
                          '$percent%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
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

              const SizedBox(height: 15),

              _whiteCard(
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: lightPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        color: purple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: navy,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Create a high-fidelity mobile application prototype using Figma. Design two linked pages and prepare the prototype for submission.',
                            style: TextStyle(
                              color: secondary,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              _whiteCard(
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.checklist_rounded,
                            color: Color(0xFFE331F2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Subtasks',
                            style: TextStyle(
                              color: navy,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            '$completedCount of 3 completed',
                            style: const TextStyle(
                              color: Color(0xFFD82CEB),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _subtask(
                      'Wireframes',
                      'Completed on 9 August',
                      wireframes,
                      () {
                        setState(() {
                          wireframes = !wireframes;
                          complete = false;
                        });
                      },
                    ),
                    const Divider(height: 1),
                    _subtask(
                      'High-fidelity screens',
                      '12 August 2026',
                      highFidelity,
                      () {
                        setState(() {
                          highFidelity = !highFidelity;
                          complete = false;
                        });
                      },
                    ),
                    const Divider(height: 1),
                    _subtask(
                      'Prototype link',
                      '15 August 2026',
                      prototype,
                      () {
                        setState(() {
                          prototype = !prototype;
                          complete = false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 51,
                child: ElevatedButton.icon(
                  onPressed: _markComplete,
                  icon: Icon(
                    complete
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded,
                  ),
                  label: Text(
                    complete
                        ? 'Completed'
                        : 'Mark as Complete',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        complete ? green : purple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StudyTrackBottomNav(
        currentIndex: 1,
        onTap: _navigate,
      ),
    );
  }

  Widget _roundButton(
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF1F2F7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: navy,
        ),
      ),
    );
  }

  Widget _summary(
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 3),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _whiteCard(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _subtask(
    String title,
    String subtitle,
    bool checked,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Icon(
              checked
                  ? Icons.check_circle_outline_rounded
                  : Icons.circle_outlined,
              color: checked ? green : secondary,
              size: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: secondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: purple,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}