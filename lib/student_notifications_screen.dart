import 'package:flutter/material.dart';
import 'app_colors.dart';

class StudentNotificationsScreen extends StatelessWidget {
  const StudentNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.assignment_rounded,
        'color': const Color(0xFF3B82F6),
        'title': 'New Homework Assigned',
        'message': 'Mathematics - Complete Chapter 5 Exercises',
        'time': '10 mins ago',
        'unread': true,
      },
      {
        'icon': Icons.quiz_rounded,
        'color': const Color(0xFFEF4444),
        'title': 'Exam Alert',
        'message': 'Mathematics exam on Monday, Dec 23',
        'time': '1 hour ago',
        'unread': true,
      },
      {
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF10B981),
        'title': 'Homework Submitted',
        'message': 'Your Science project has been submitted successfully',
        'time': '2 hours ago',
        'unread': false,
      },
      {
        'icon': Icons.event_rounded,
        'color': const Color(0xFF6366F1),
        'title': 'Sports Day Reminder',
        'message': 'Annual Sports Day on Dec 20. Don\'t forget your sports uniform!',
        'time': 'Yesterday',
        'unread': false,
      },
      {
        'icon': Icons.grade_rounded,
        'color': const Color(0xFFF59E0B),
        'title': 'Marks Updated',
        'message': 'Your English test marks have been uploaded',
        'time': 'Yesterday',
        'unread': false,
      },
      {
        'icon': Icons.campaign_rounded,
        'color': const Color(0xFF8B5CF6),
        'title': 'School Announcement',
        'message': 'Parent-Teacher Meeting scheduled for Friday',
        'time': '2 days ago',
        'unread': false,
      },
      {
        'icon': Icons.library_books_rounded,
        'color': const Color(0xFF06B6D4),
        'title': 'Library Reminder',
        'message': 'Return "Harry Potter" book by Dec 25',
        'time': '2 days ago',
        'unread': false,
      },
      {
        'icon': Icons.payment_rounded,
        'color': const Color(0xFFF59E0B),
        'title': 'Fee Reminder',
        'message': 'School fee payment due by Dec 31',
        'time': '3 days ago',
        'unread': false,
      },
      {
        'icon': Icons.celebration_rounded,
        'color': const Color(0xFFEC4899),
        'title': 'Achievement Unlocked',
        'message': 'Congratulations! You scored 95% in Science test',
        'time': '1 week ago',
        'unread': false,
      },
      {
        'icon': Icons.schedule_rounded,
        'color': const Color(0xFF3B82F6),
        'title': 'Timetable Updated',
        'message': 'New timetable for next week has been uploaded',
        'time': '1 week ago',
        'unread': false,
      },
    ];

    final unreadCount = notifications.where((n) => n['unread'] == true).length;

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
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {},
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(unreadCount),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int unreadCount) {
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
              Icons.notifications_active_rounded,
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
                  'Stay Updated',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  unreadCount > 0
                      ? '$unreadCount new notification${unreadCount > 1 ? 's' : ''}'
                      : 'All caught up!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isUnread = notification['unread'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread
              ? (notification['color'] as Color).withOpacity(0.3)
              : const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isUnread ? 0.06 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  notification['color'] as Color,
                  (notification['color'] as Color).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification['icon'] as IconData,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isUnread ? FontWeight.w800 : FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: notification['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notification['message'],
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF64748B),
                    fontWeight: isUnread ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: notification['color'] as Color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notification['time'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: notification['color'] as Color,
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
}
