import 'package:flutter/material.dart';
import 'app_colors.dart';

class TeacherScheduleScreen extends StatelessWidget {
  const TeacherScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schedule = [
      {'time': '09:00 - 09:45', 'class': 'Class 8 - Section A', 'subject': 'Mathematics', 'room': 'Room 101', 'current': true},
      {'time': '09:50 - 10:35', 'class': 'Class 5 - Section B', 'subject': 'Science', 'room': 'Lab 1', 'current': false},
      {'time': '10:40 - 11:25', 'class': 'Free Period', 'subject': '', 'room': '', 'current': false, 'isFree': true},
      {'time': '11:30 - 12:15', 'class': 'Class 7 - Section A', 'subject': 'Mathematics', 'room': 'Room 102', 'current': false},
      {'time': '12:15 - 01:00', 'class': 'Lunch Break', 'subject': '', 'room': '', 'current': false, 'isBreak': true},
      {'time': '01:00 - 01:45', 'class': 'Class 6 - Section C', 'subject': 'Science', 'room': 'Lab 2', 'current': false},
      {'time': '01:50 - 02:35', 'class': 'Class 8 - Section B', 'subject': 'Mathematics', 'room': 'Room 101', 'current': false},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Schedule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                return _buildScheduleCard(schedule[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A56DB), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Friday, December 20, 2024',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> item, int index) {
    final isCurrent = item['current'] == true;
    final isFree = item['isFree'] == true;
    final isBreak = item['isBreak'] == true;

    Color bgColor;
    Color borderColor;
    Color iconColor;
    IconData icon;

    if (isCurrent) {
      bgColor = const Color(0xFFDBEAFE);
      borderColor = AppColors.primary;
      iconColor = AppColors.primary;
      icon = Icons.play_circle_filled_rounded;
    } else if (isFree) {
      bgColor = const Color(0xFFF8FAFC);
      borderColor = const Color(0xFFE2E8F0);
      iconColor = const Color(0xFF64748B);
      icon = Icons.free_breakfast_rounded;
    } else if (isBreak) {
      bgColor = const Color(0xFFFEF3C7);
      borderColor = const Color(0xFFF59E0B);
      iconColor = const Color(0xFFF59E0B);
      icon = Icons.restaurant_rounded;
    } else {
      bgColor = Colors.white;
      borderColor = const Color(0xFFF1F5F9);
      iconColor = const Color(0xFF10B981);
      icon = Icons.schedule_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isCurrent ? 0.08 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['class'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isFree || isBreak ? const Color(0xFF64748B) : const Color(0xFF1E293B),
                  ),
                ),
                if (!isFree && !isBreak) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.book_outlined, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item['subject'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        item['room'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              item['time'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
