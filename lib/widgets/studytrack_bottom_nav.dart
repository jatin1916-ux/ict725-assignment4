import 'package:flutter/material.dart';

class StudyTrackBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const StudyTrackBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color purple = Color(0xFF6048F5);
  static const Color inactive = Color(0xFF75809E);
  static const Color selectedBackground = Color(0xFFF0EDFF);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          border: Border.all(
            color: const Color(0xFFE6E7ED),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
        child: Row(
          children: [
            _item(
              index: 0,
              icon: Icons.home_outlined,
              selectedIcon: Icons.home_rounded,
              label: 'Home',
            ),
            _item(
              index: 1,
              icon: Icons.assignment_turned_in_outlined,
              selectedIcon: Icons.assignment_turned_in_rounded,
              label: 'Tasks',
            ),
            _item(
              index: 2,
              icon: Icons.calendar_month_outlined,
              selectedIcon: Icons.calendar_month_rounded,
              label: 'Calendar',
            ),
            _item(
              index: 3,
              icon: Icons.person_outline_rounded,
              selectedIcon: Icons.person_rounded,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final selected = currentIndex == index;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 3,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? selectedBackground
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected ? selectedIcon : icon,
                  size: 28,
                  color: selected ? purple : inactive,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    color: selected ? purple : inactive,
                    fontSize: 12,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}