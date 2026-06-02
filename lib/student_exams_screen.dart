import 'package:flutter/material.dart';
import 'app_colors.dart';

class StudentExamsScreen extends StatelessWidget {
  const StudentExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = [
      {
        'subject': 'Mathematics',
        'date': 'Monday, Dec 23, 2024',
        'time': '09:00 AM - 11:00 AM',
        'duration': '2 hours',
        'chapters': 'Chapters 5-7',
        'room': 'Room 101',
        'totalMarks': '100',
        'type': 'Unit Test',
        'daysLeft': 3,
      },
      {
        'subject': 'Science',
        'date': 'Wednesday, Dec 25, 2024',
        'time': '09:00 AM - 11:00 AM',
        'duration': '2 hours',
        'chapters': 'Chapters 8-10',
        'room': 'Lab 1',
        'totalMarks': '100',
        'type': 'Unit Test',
        'daysLeft': 5,
      },
      {
        'subject': 'English',
        'date': 'Friday, Dec 27, 2024',
        'time': '10:00 AM - 12:00 PM',
        'duration': '2 hours',
        'chapters': 'All Chapters',
        'room': 'Room 203',
        'totalMarks': '100',
        'type': 'Term Exam',
        'daysLeft': 7,
      },
      {
        'subject': 'Social Studies',
        'date': 'Monday, Dec 30, 2024',
        'time': '09:00 AM - 11:00 AM',
        'duration': '2 hours',
        'chapters': 'Chapters 1-5',
        'room': 'Room 105',
        'totalMarks': '80',
        'type': 'Unit Test',
        'daysLeft': 10,
      },
      {
        'subject': 'Hindi',
        'date': 'Wednesday, Jan 2, 2025',
        'time': '10:00 AM - 12:00 PM',
        'duration': '2 hours',
        'chapters': 'All Chapters',
        'room': 'Room 202',
        'totalMarks': '100',
        'type': 'Term Exam',
        'daysLeft': 13,
      },
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
          'Upcoming Exams',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(exams.length),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return _buildExamCard(exams[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int examCount) {
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
              Icons.quiz_rounded,
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
                  'Exam Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$examCount exams scheduled',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFBBF24),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard(Map<String, dynamic> exam, int index) {
    final colors = [
      {'bg': const Color(0xFFDBEAFE), 'icon': AppColors.primary},
      {'bg': const Color(0xFFD1FAE5), 'icon': const Color(0xFF10B981)},
      {'bg': const Color(0xFFFEF3C7), 'icon': const Color(0xFFF59E0B)},
      {'bg': const Color(0xFFEDE9FE), 'icon': const Color(0xFF6366F1)},
      {'bg': const Color(0xFFFEE2E2), 'icon': const Color(0xFFEF4444)},
    ];
    final colorSet = colors[index % colors.length];
    final daysLeft = exam['daysLeft'] as int;
    final isUrgent = daysLeft <= 5;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUrgent
              ? const Color(0xFFEF4444).withOpacity(0.3)
              : const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colorSet['bg'] as Color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.quiz_rounded,
                    color: colorSet['icon'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exam['subject'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: colorSet['icon'] as Color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          exam['type'],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: colorSet['icon'] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isUrgent ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        daysLeft.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'days',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                _buildInfoRow(Icons.calendar_today_rounded, 'Date', exam['date']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.access_time_rounded, 'Time', exam['time']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.timer_outlined, 'Duration', exam['duration']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.book_outlined, 'Syllabus', exam['chapters']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.location_on_outlined, 'Room', exam['room']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.grade_rounded, 'Total Marks', exam['totalMarks']),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_active_rounded, size: 18),
                        label: const Text('Set Reminder'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorSet['icon'] as Color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.download_rounded, size: 18, color: colorSet['icon'] as Color),
                        label: Text(
                          'Syllabus',
                          style: TextStyle(color: colorSet['icon'] as Color),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: colorSet['icon'] as Color, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF64748B)),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      ],
    );
  }
}
