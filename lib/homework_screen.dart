import 'package:flutter/material.dart';
import 'app_colors.dart';

class HomeworkScreen extends StatelessWidget {
  final String childName;
  final int pendingCount;

  const HomeworkScreen({
    super.key,
    required this.childName,
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    final assignments = [
      {'title': 'Math Worksheet Ch-5', 'subject': 'Mathematics', 'due': 'Tomorrow', 'status': 'Pending'},
      {'title': 'Science Project', 'subject': 'Science', 'due': 'Dec 20', 'status': 'Pending'},
      {'title': 'English Essay', 'subject': 'English', 'due': 'Dec 18', 'status': 'Completed'},
      {'title': 'History Assignment', 'subject': 'Social Studies', 'due': 'Dec 15', 'status': 'Completed'},
    ];

    final pending = assignments.where((a) => a['status'] == 'Pending').toList();
    final completed = assignments.where((a) => a['status'] == 'Completed').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text('$childName - Homework'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(pending.length, completed.length),
            const SizedBox(height: 24),
            _buildSectionLabel('Pending Assignments'),
            const SizedBox(height: 12),
            ...pending.map((hw) => _buildHomeworkCard(hw, false)),
            const SizedBox(height: 20),
            _buildSectionLabel('Completed Assignments'),
            const SizedBox(height: 12),
            ...completed.map((hw) => _buildHomeworkCard(hw, true)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(int pending, int completed) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withOpacity(0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(pending.toString(), 'Pending', Icons.pending_actions_rounded),
          Container(width: 1, height: 50, color: Colors.white.withOpacity(0.3)),
          _buildStatColumn(completed.toString(), 'Completed', Icons.check_circle_rounded),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeworkCard(Map<String, String> hw, bool completed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: completed
                  ? const Color(0xFFD1FAE5)
                  : const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              completed ? Icons.check_circle_rounded : Icons.assignment_outlined,
              color: completed
                  ? const Color(0xFF10B981)
                  : const Color(0xFFF59E0B),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hw['title']!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hw['subject']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: completed
                          ? const Color(0xFF10B981)
                          : const Color(0xFFF59E0B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${hw['due']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: completed
                            ? const Color(0xFF10B981)
                            : const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: completed
                  ? const Color(0xFF10B981)
                  : const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              hw['status']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
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
