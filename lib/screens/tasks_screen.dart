import 'package:flutter/material.dart';
import '../widgets/studytrack_bottom_nav.dart';
import 'task_details_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  static const Color background = Color(0xFFF8F9FE);
  static const Color navy = Color(0xFF11183F);
  static const Color secondary = Color(0xFF7B86A8);
  static const Color purple = Color(0xFF6048F5);
  static const Color lightPurple = Color(0xFFF1EEFF);
  static const Color pink = Color(0xFFFF5F8A);

  final TextEditingController _searchController = TextEditingController();

  String _filter = 'All';
  String _search = '';

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'UX Prototype Assignment',
      'subject': 'ICT725',
      'due': '15 August 2026',
      'progress': 0.70,
      'priority': 'High',
      'completed': false,
      'type': 'document',
    },
    {
      'title': 'Database Quiz',
      'subject': 'ICT725',
      'due': '15 August 2026',
      'progress': 0.20,
      'priority': 'Medium',
      'completed': false,
      'type': 'database',
    },
    {
      'title': 'Mobile App Report',
      'subject': 'ICT725',
      'due': '07 September 2026',
      'progress': 0.10,
      'priority': 'Medium',
      'completed': false,
      'type': 'mobile',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredTasks {
    return _tasks.where((task) {
      final searchMatch = task['title']
          .toString()
          .toLowerCase()
          .contains(_search.toLowerCase());

      if (!searchMatch) return false;

      if (_filter == 'Completed') {
        return task['completed'] == true;
      }

      if (_filter == 'Upcoming') {
        return task['completed'] == false;
      }

      return true;
    }).toList();
  }

  void _navigate(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      return;
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/calendar');
    } else {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  void _openTask(Map<String, dynamic> task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskDetailsScreen(
          title: task['title'],
          subject: task['subject'],
          dueDate: task['due'],
          initialProgress: task['progress'],
          priority: task['priority'],
        ),
      ),
    );
  }

  IconData _iconForTask(String type) {
    switch (type) {
      case 'database':
        return Icons.storage_rounded;
      case 'mobile':
        return Icons.phone_android_rounded;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  void _addTask() {
    final title = TextEditingController();
    final subject = TextEditingController(text: 'ICT725');
    final due = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            22,
            22,
            22,
            MediaQuery.of(context).viewInsets.bottom + 22,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    color: navy,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  labelText: 'Task title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subject,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: due,
                decoration: const InputDecoration(
                  labelText: 'Due date',
                  hintText: 'e.g. 20 August 2026',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (title.text.trim().isEmpty) return;

                    setState(() {
                      _tasks.add({
                        'title': title.text.trim(),
                        'subject': subject.text.trim().isEmpty
                            ? 'ICT725'
                            : subject.text.trim(),
                        'due': due.text.trim().isEmpty
                            ? 'Not set'
                            : due.text.trim(),
                        'progress': 0.0,
                        'priority': 'Medium',
                        'completed': false,
                        'type': 'document',
                      });
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add Task'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 26),
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
                          'Tasks',
                          style: TextStyle(
                            color: navy,
                            fontSize: 33,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Manage your study tasks',
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

              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _search = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF8D8D94),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  _filterButton('All'),
                  const SizedBox(width: 8),
                  _filterButton('Upcoming'),
                  const SizedBox(width: 8),
                  _filterButton('Completed'),
                ],
              ),

              const SizedBox(height: 20),

              if (filteredTasks.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Text(
                      'No tasks found',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              else
                ...filteredTasks.map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () => _openTask(task),
                      child: task['title'] ==
                              'UX Prototype Assignment'
                          ? _featuredCard(task)
                          : _normalCard(task),
                    ),
                  ),
                ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                  ),
                  label: const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
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

  Widget _filterButton(String name) {
    final selected = _filter == name;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _filter = name;
          });
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? purple : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            name,
            style: TextStyle(
              color: selected ? Colors.white : navy,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _featuredCard(Map<String, dynamic> task) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(13, 18, 13, 13),
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
                      task['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 1.16,
                      ),
                    ),
                    Text(
                      task['subject'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                          size: 17,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'Due: ${task['due'].toString().replaceAll(' 2026', '')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: pink,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        task['priority'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.star_rounded,
                color: Colors.white,
                size: 29,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                '${(task['progress'] * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: task['progress'],
                  minHeight: 7,
                  color: Colors.white,
                  backgroundColor: Colors.white30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _normalCard(Map<String, dynamic> task) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.11),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
              color: lightPurple,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _iconForTask(task['type']),
              color: purple,
              size: 29,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  task['subject'],
                  style: const TextStyle(
                    color: secondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: secondary,
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Due: ${task['due'].toString().replaceAll(' 2026', '')}',
                        style: const TextStyle(
                          color: secondary,
                          fontSize: 14,
                        ),
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
            ),
          ),
        ],
      ),
    );
  }
}