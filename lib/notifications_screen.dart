import 'package:flutter/material.dart';
import 'app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'PTM scheduled on Friday',
        'message': 'Parent-Teacher Meeting is scheduled for Dec 20 at 10:00 AM in the school auditorium.',
        'time': '2 hours ago',
        'icon': Icons.event_note_rounded,
        'color': const Color(0xFF3B82F6),
        'unread': true,
      },
      {
        'title': 'Math homework submitted',
        'message': 'Your child has successfully submitted the Math worksheet for Chapter 5.',
        'time': 'Yesterday',
        'icon': Icons.check_circle_outline_rounded,
        'color': const Color(0xFF10B981),
        'unread': true,
      },
      {
        'title': 'Annual Sports Day',
        'message': 'Annual Sports Day will be held on Dec 20. Students should wear sports uniform.',
        'time': '2 days ago',
        'icon': Icons.sports_soccer_rounded,
        'color': const Color(0xFF10B981),
        'unread': false,
      },
      {
        'title': 'Fee reminder',
        'message': 'School fees for the current term are due by Dec 31, 2024. Please make the payment.',
        'time': '3 days ago',
        'icon': Icons.payment_rounded,
        'color': const Color(0xFFF59E0B),
        'unread': false,
      },
      {
        'title': 'Exam schedule released',
        'message': 'Mid-term examination schedule has been released. Check the timetable section.',
        'time': '4 days ago',
        'icon': Icons.assignment_rounded,
        'color': const Color(0xFF6366F1),
        'unread': false,
      },
      {
        'title': 'Library book due',
        'message': 'The library book "Science Adventures" is due for return by Dec 18.',
        'time': '5 days ago',
        'icon': Icons.book_rounded,
        'color': const Color(0xFFEC4899),
        'unread': false,
      },
      {
        'title': 'School holiday notice',
        'message': 'School will remain closed on Dec 25 for Christmas celebration.',
        'time': '1 week ago',
        'icon': Icons.celebration_rounded,
        'color': const Color(0xFFF59E0B),
        'unread': false,
      },
      {
        'title': 'Attendance alert',
        'message': 'Your child\'s attendance has dropped below 85%. Please ensure regular attendance.',
        'time': '1 week ago',
        'icon': Icons.warning_rounded,
        'color': const Color(0xFFEF4444),
        'unread': false,
      },
    ];

    final unreadCount = notifications.where((n) => n['unread'] == true).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications marked as read'),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (unreadCount > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              color: const Color(0xFFDBEAFE),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'You have $unreadCount unread notification${unreadCount > 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationCard(notif);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    final isUnread = notif['unread'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: isUnread
            ? Border.all(
                color: (notif['color'] as Color).withOpacity(0.3),
                width: 1.5,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isUnread ? 0.08 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
              color: (notif['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notif['icon'] as IconData,
              color: notif['color'] as Color,
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
                        notif['title'] as String,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: notif['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notif['message'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: isUnread
                        ? const Color(0xFF475569)
                        : const Color(0xFF94A3B8),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: notif['color'] as Color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notif['time'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: notif['color'] as Color,
                        fontWeight: FontWeight.w600,
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
