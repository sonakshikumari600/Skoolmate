import 'package:flutter/material.dart';
import 'app_colors.dart';

class StudentTimetableScreen extends StatefulWidget {
  const StudentTimetableScreen({super.key});

  @override
  State<StudentTimetableScreen> createState() => _StudentTimetableScreenState();
}

class _StudentTimetableScreenState extends State<StudentTimetableScreen> {
  String _selectedDay = 'Monday';

  final Map<String, List<Map<String, String>>> _timetable = {
    'Monday': [
      {'time': '09:00 - 09:45', 'subject': 'Mathematics', 'teacher': 'Mr. Rajesh Kumar', 'room': 'Room 101'},
      {'time': '09:50 - 10:35', 'subject': 'Science', 'teacher': 'Dr. Anjali Verma', 'room': 'Lab 1'},
      {'time': '10:40 - 11:25', 'subject': 'English', 'teacher': 'Ms. Priya Sharma', 'room': 'Room 203'},
      {'time': '11:30 - 12:15', 'subject': 'Social Studies', 'teacher': 'Mr. Vikram Singh', 'room': 'Room 105'},
      {'time': '12:15 - 01:00', 'subject': 'Lunch Break', 'teacher': '', 'room': ''},
      {'time': '01:00 - 01:45', 'subject': 'Hindi', 'teacher': 'Mrs. Sunita Devi', 'room': 'Room 202'},
      {'time': '01:50 - 02:35', 'subject': 'Computer Science', 'teacher': 'Mr. Anil Gupta', 'room': 'Lab 2'},
    ],
    'Tuesday': [
      {'time': '09:00 - 09:45', 'subject': 'Science', 'teacher': 'Dr. Anjali Verma', 'room': 'Lab 1'},
      {'time': '09:50 - 10:35', 'subject': 'Mathematics', 'teacher': 'Mr. Rajesh Kumar', 'room': 'Room 101'},
      {'time': '10:40 - 11:25', 'subject': 'Physical Education', 'teacher': 'Coach Ramesh', 'room': 'Ground'},
      {'time': '11:30 - 12:15', 'subject': 'English', 'teacher': 'Ms. Priya Sharma', 'room': 'Room 203'},
      {'time': '12:15 - 01:00', 'subject': 'Lunch Break', 'teacher': '', 'room': ''},
      {'time': '01:00 - 01:45', 'subject': 'Art & Craft', 'teacher': 'Ms. Kavita Rao', 'room': 'Art Room'},
      {'time': '01:50 - 02:35', 'subject': 'Social Studies', 'teacher': 'Mr. Vikram Singh', 'room': 'Room 105'},
    ],
    'Wednesday': [
      {'time': '09:00 - 09:45', 'subject': 'English', 'teacher': 'Ms. Priya Sharma', 'room': 'Room 203'},
      {'time': '09:50 - 10:35', 'subject': 'Hindi', 'teacher': 'Mrs. Sunita Devi', 'room': 'Room 202'},
      {'time': '10:40 - 11:25', 'subject': 'Mathematics', 'teacher': 'Mr. Rajesh Kumar', 'room': 'Room 101'},
      {'time': '11:30 - 12:15', 'subject': 'Science', 'teacher': 'Dr. Anjali Verma', 'room': 'Lab 1'},
      {'time': '12:15 - 01:00', 'subject': 'Lunch Break', 'teacher': '', 'room': ''},
      {'time': '01:00 - 01:45', 'subject': 'Computer Science', 'teacher': 'Mr. Anil Gupta', 'room': 'Lab 2'},
      {'time': '01:50 - 02:35', 'subject': 'Music', 'teacher': 'Mr. Suresh Iyer', 'room': 'Music Room'},
    ],
    'Thursday': [
      {'time': '09:00 - 09:45', 'subject': 'Mathematics', 'teacher': 'Mr. Rajesh Kumar', 'room': 'Room 101'},
      {'time': '09:50 - 10:35', 'subject': 'Social Studies', 'teacher': 'Mr. Vikram Singh', 'room': 'Room 105'},
      {'time': '10:40 - 11:25', 'subject': 'Science', 'teacher': 'Dr. Anjali Verma', 'room': 'Lab 1'},
      {'time': '11:30 - 12:15', 'subject': 'English', 'teacher': 'Ms. Priya Sharma', 'room': 'Room 203'},
      {'time': '12:15 - 01:00', 'subject': 'Lunch Break', 'teacher': '', 'room': ''},
      {'time': '01:00 - 01:45', 'subject': 'Hindi', 'teacher': 'Mrs. Sunita Devi', 'room': 'Room 202'},
      {'time': '01:50 - 02:35', 'subject': 'Physical Education', 'teacher': 'Coach Ramesh', 'room': 'Ground'},
    ],
    'Friday': [
      {'time': '09:00 - 09:45', 'subject': 'Science', 'teacher': 'Dr. Anjali Verma', 'room': 'Lab 1'},
      {'time': '09:50 - 10:35', 'subject': 'English', 'teacher': 'Ms. Priya Sharma', 'room': 'Room 203'},
      {'time': '10:40 - 11:25', 'subject': 'Mathematics', 'teacher': 'Mr. Rajesh Kumar', 'room': 'Room 101'},
      {'time': '11:30 - 12:15', 'subject': 'Computer Science', 'teacher': 'Mr. Anil Gupta', 'room': 'Lab 2'},
      {'time': '12:15 - 01:00', 'subject': 'Lunch Break', 'teacher': '', 'room': ''},
      {'time': '01:00 - 01:45', 'subject': 'Social Studies', 'teacher': 'Mr. Vikram Singh', 'room': 'Room 105'},
      {'time': '01:50 - 02:35', 'subject': 'Library Period', 'teacher': 'Ms. Meera Nair', 'room': 'Library'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final classes = _timetable[_selectedDay] ?? [];

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
          'My Timetable',
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
          _buildDaySelector(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                return _buildClassCard(classes[index], index);
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
              Icons.schedule_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Class 8 - Section A',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
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

  Widget _buildDaySelector() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = _selectedDay == day;

          return GestureDetector(
            onTap: () => setState(() => _selectedDay = day),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF1A56DB), Color(0xFF3B82F6)],
                      )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                day.substring(0, 3),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassCard(Map<String, String> classInfo, int index) {
    final isBreak = classInfo['subject'] == 'Lunch Break';
    final colors = [
      {'bg': const Color(0xFFDBEAFE), 'icon': AppColors.primary},
      {'bg': const Color(0xFFD1FAE5), 'icon': const Color(0xFF10B981)},
      {'bg': const Color(0xFFFEF3C7), 'icon': const Color(0xFFF59E0B)},
      {'bg': const Color(0xFFEDE9FE), 'icon': const Color(0xFF6366F1)},
      {'bg': const Color(0xFFFEE2E2), 'icon': const Color(0xFFEF4444)},
    ];
    final colorSet = colors[index % colors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isBreak ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isBreak ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              color: isBreak ? const Color(0xFFE2E8F0) : colorSet['bg'] as Color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isBreak ? Icons.restaurant_rounded : Icons.book_rounded,
              color: isBreak ? const Color(0xFF64748B) : colorSet['icon'] as Color,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classInfo['subject']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isBreak ? const Color(0xFF64748B) : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                if (!isBreak) ...[
                  Row(
                    children: [
                      const Icon(Icons.person_outline_rounded, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          classInfo['teacher']!,
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
                        classInfo['room']!,
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
              color: isBreak ? const Color(0xFFE2E8F0) : colorSet['bg'] as Color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              classInfo['time']!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isBreak ? const Color(0xFF64748B) : colorSet['icon'] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
