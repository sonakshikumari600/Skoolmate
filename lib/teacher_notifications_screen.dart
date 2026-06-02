import 'package:flutter/material.dart';
import 'app_colors.dart';

class TeacherNotificationsScreen extends StatelessWidget {
  const TeacherNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.event_rounded,
        'color': const Color(0xFF3B82F6),
        'title': 'Staff Meeting',
        'message': 'Staff meeting scheduled at 2:00 PM in the conference room',
        'time': '30 mins ago',
        'unread': true,
      },
      {
        'icon': Icons.alarm_rounded,
        'color': const Color(0xFFEF4444),
        'title': 'Attendance Reminder',
        'message': 'Please submit attendance for Class 8A before 5:00 PM today',
        'time': '1 hour ago',
        'unread': true,
      },
      {
        'icon': Icons.assignment_turned_in_rounded,
        'color': const Color(0xFF10B981),
        'title': 'Homework Submitted',
        'message': '28 students from Class 8A have submitted their homework',
        'time': '2 hours ago',
        'unread': false,
      },
      {
        'icon': Icons.grade_rounded,
        'color': const Color(0xFFF59E0B),
        'title': 'Grading Reminder',
        'message': 'Math test papers for Class 7A need to be graded by tomorrow',
        'time': 'Yesterday',
        'unread': false,
      },
      {
        'icon': Icons.campaign_rounded,
        'color': const Color(0xFF6366F1),
        'title': 'School Announcement',
        'message': 'Annual Sports Day will be held on December 25, 2024',
        'time': '2 days ago',
        'unread': false,
      },
      {
        'icon': Icons.person_add_rounded,
        'color': const Color(0xFF10B981),
        'title': 'New Student Added',
        'message': 'A new student has been added to Class 5B',
        'time': '3 days ago',
        'unread': false,
      },
      {
        'icon': Icons.update_rounded,
        'color': const Color(0xFF3B82F6),
        'title': 'Timetable Updated',
        'message': 'Your timetable for next week has been updated',
        'time': '3 days ago',
        'unread': false,
      },
      {
        'icon': Icons.celebration_rounded,
        'color': const Color(0xFFEC4899),
        'title': 'Achievement',
        'message': 'Your class 8A scored highest in the recent Math test!',
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
                  style: const TextStyle(
                    color: Colors.white70,
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
