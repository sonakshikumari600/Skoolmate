import 'package:flutter/material.dart';
import 'app_colors.dart';

class TimetableScreen extends StatelessWidget {
  final String childName;
  final int classesToday;

  const TimetableScreen({
    super.key,
    required this.childName,
    required this.classesToday,
  });

  @override
  Widget build(BuildContext context) {
    final schedule = [
      {'time': '08:00 - 08:45', 'subject': 'Mathematics', 'teacher': 'Mr. Sharma', 'color': const Color(0xFF3B82F6)},
      {'time': '08:45 - 09:30', 'subject': 'Science', 'teacher': 'Ms. Gupta', 'color': const Color(0xFF10B981)},
      {'time': '09:30 - 10:15', 'subject': 'English', 'teacher': 'Mrs. Verma', 'color': const Color(0xFF6366F1)},
      {'time': '10:15 - 10:30', 'subject': 'Break', 'teacher': '', 'color': const Color(0xFF94A3B8)},
      {'time': '10:30 - 11:15', 'subject': 'Social Studies', 'teacher': 'Mr. Kumar', 'color': const Color(0xFFF59E0B)},
      {'time': '11:15 - 12:00', 'subject': 'Hindi', 'teacher': 'Ms. Patel', 'color': const Color(0xFFEC4899)},
      {'time': '12:00 - 12:45', 'subject': 'Physical Education', 'teacher': 'Mr. Singh', 'color': const Color(0xFF14B8A6)},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text('$childName - Timetable'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionLabel('Today\'s Schedule'),
            const SizedBox(height: 12),
            ...schedule.map((item) => _buildClassCard(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF34D399)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.schedule_rounded,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Classes',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$classesToday Classes',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Monday, Dec 16',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> item) {
    final isBreak = item['subject'] == 'Break';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isBreak
            ? Border.all(color: const Color(0xFFE2E8F0), width: 2)
            : null,
        boxShadow: isBreak
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: item['color'],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['time'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['subject'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isBreak
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF1E293B),
                  ),
                ),
                if (!isBreak) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 14,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['teacher'],
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
          if (!isBreak)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.book_rounded,
                color: item['color'],
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
