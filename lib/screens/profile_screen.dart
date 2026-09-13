import 'package:flutter/material.dart';
import '../widgets/studytrack_bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color background = Color(0xFFF8F9FE);
  static const Color navy = Color(0xFF11183F);
  static const Color secondary = Color(0xFF7B86A8);
  static const Color purple = Color(0xFF6048F5);
  static const Color lightPurple = Color(0xFFF1EEFF);
  static const Color green = Color(0xFF08B894);

  String name = 'Alex';
  String role = 'ICT725 Student';

  void _navigate(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/tasks');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/calendar');
    }
  }

  void _editProfile() {
    final nameController = TextEditingController(text: name);
    final roleController = TextEditingController(text: role);

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
                  'Edit Profile',
                  style: TextStyle(
                    color: navy,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) {
                      return;
                    }

                    setState(() {
                      name = nameController.text.trim();

                      if (roleController.text.trim().isNotEmpty) {
                        role = roleController.text.trim();
                      }
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _message(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name selected'),
        behavior: SnackBarBehavior.floating,
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
                          'Profile',
                          style: TextStyle(
                            color: navy,
                            fontSize: 33,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Manage your study account',
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

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.09),
                      blurRadius: 7,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDCD4FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: purple,
                        size: 55,
                      ),
                    ),
                    const SizedBox(width: 17),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: navy,
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            role,
                            style: const TextStyle(
                              color: secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Stay organised and keep\ntrack of your studies',
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

              const SizedBox(height: 14),

              const Row(
                children: [
                  Expanded(
                    child: _ProfileStat(
                      number: '3',
                      label: 'Tasks due\nthis week',
                      accent: purple,
                      background: lightPurple,
                      icon: Icons.assignment_outlined,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ProfileStat(
                      number: '12',
                      label: 'Completed\nthis month',
                      accent: green,
                      background: Color(0xFFE4F8F2),
                      icon: Icons.check_circle_outline_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _menu(
                      Icons.person_outline_rounded,
                      'Personal Information',
                    ),
                    const _MenuDivider(),
                    _menu(
                      Icons.notifications_none_rounded,
                      'Notifications',
                    ),
                    const _MenuDivider(),
                    _menu(
                      Icons.bar_chart_rounded,
                      'Study Progress',
                    ),
                    const _MenuDivider(),
                    _menu(
                      Icons.help_outline_rounded,
                      'Help & Support',
                    ),
                    const _MenuDivider(),
                    _menu(
                      Icons.settings_outlined,
                      'Settings',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 51,
                child: ElevatedButton.icon(
                  onPressed: _editProfile,
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 19,
                  ),
                  label: const Text(
                    'Edit Profile',
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
        currentIndex: 3,
        onTap: _navigate,
      ),
    );
  }

  Widget _menu(IconData icon, String text) {
    return InkWell(
      onTap: () => _message(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: purple,
                size: 23,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: navy,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: purple,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String number;
  final String label;
  final Color accent;
  final Color background;
  final IconData icon;

  const _ProfileStat({
    required this.number,
    required this.label,
    required this.accent,
    required this.background,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 92,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: accent,
              size: 23,
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
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 2,
                  style: const TextStyle(
                    color: _ProfileScreenState.navy,
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

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 56,
      color: Color(0xFFE3E5ED),
    );
  }
}