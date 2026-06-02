import 'package:flutter/material.dart';
import 'app_colors.dart';

class StudentHomeworkScreen extends StatefulWidget {
  const StudentHomeworkScreen({super.key});

  @override
  State<StudentHomeworkScreen> createState() => _StudentHomeworkScreenState();
}

class _StudentHomeworkScreenState extends State<StudentHomeworkScreen> {
  final List<Map<String, dynamic>> _homework = [
    {
      'subject': 'Mathematics',
      'title': 'Complete Chapter 5 Exercises',
      'description': 'Solve all problems from Exercise 5.1 to 5.3',
      'dueDate': 'Tomorrow',
      'status': 'pending',
      'urgent': true,
      'assignedDate': 'Dec 19, 2024',
    },
    {
      'subject': 'Science',
      'title': 'Science Project - Solar System',
      'description': 'Create a model of the solar system',
      'dueDate': 'Dec 25, 2024',
      'status': 'pending',
      'urgent': false,
      'assignedDate': 'Dec 15, 2024',
    },
    {
      'subject': 'English',
      'title': 'Essay Writing',
      'description': 'Write an essay on "My Favorite Book" (500 words)',
      'dueDate': 'Dec 23, 2024',
      'status': 'pending',
      'urgent': false,
      'assignedDate': 'Dec 18, 2024',
    },
    {
      'subject': 'Hindi',
      'title': 'Hindi Grammar Worksheet',
      'description': 'Complete worksheet on Sangya and Sarvanam',
      'dueDate': 'Completed',
      'status': 'completed',
      'urgent': false,
      'assignedDate': 'Dec 16, 2024',
    },
    {
      'subject': 'Social Studies',
      'title': 'Map Work',
      'description': 'Draw and label map of India with all states',
      'dueDate': 'Completed',
      'status': 'completed',
      'urgent': false,
      'assignedDate': 'Dec 10, 2024',
    },
    {
      'subject': 'Computer Science',
      'title': 'Python Programming',
      'description': 'Write programs for loops and functions',
      'dueDate': 'Dec 24, 2024',
      'status': 'pending',
      'urgent': false,
      'assignedDate': 'Dec 17, 2024',
    },
  ];

  String _filter = 'all'; // all, pending, completed

  @override
  Widget build(BuildContext context) {
    final filteredHomework = _homework.where((hw) {
      if (_filter == 'pending') return hw['status'] == 'pending';
      if (_filter == 'completed') return hw['status'] == 'completed';
      return true;
    }).toList();

    final pendingCount = _homework.where((hw) => hw['status'] == 'pending').length;
    final completedCount = _homework.where((hw) => hw['status'] == 'completed').length;

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
          'My Homework',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(pendingCount, completedCount),
          const SizedBox(height: 16),
          _buildFilterTabs(pendingCount, completedCount),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: filteredHomework.length,
              itemBuilder: (context, index) {
                return _buildHomeworkCard(filteredHomework[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int pending, int completed) {
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
          Expanded(
            child: _buildStatCard(
              icon: Icons.pending_actions_rounded,
              label: 'Pending',
              value: pending.toString(),
              color: const Color(0xFFFBBF24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              icon: Icons.check_circle_rounded,
              label: 'Completed',
              value: completed.toString(),
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(int pending, int completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterTab('All', 'all', _homework.length),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildFilterTab('Pending', 'pending', pending),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildFilterTab('Done', 'completed', completed),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, String value, int count) {
    final isSelected = _filter == value;

    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkCard(Map<String, dynamic> homework) {
    final isCompleted = homework['status'] == 'completed';
    final isUrgent = homework['urgent'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUrgent && !isCompleted
              ? const Color(0xFFEF4444).withOpacity(0.3)
              : const Color(0xFFF1F5F9),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  homework['subject'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              if (isUrgent && !isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'URGENT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'DONE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            homework['title'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            homework['description'],
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF64748B),
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: isUrgent && !isCompleted
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF94A3B8),
              ),
              const SizedBox(width: 6),
              Text(
                'Due: ${homework['dueDate']}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isUrgent && !isCompleted
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF64748B),
                ),
              ),
              const Spacer(),
              Text(
                'Assigned: ${homework['assignedDate']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
