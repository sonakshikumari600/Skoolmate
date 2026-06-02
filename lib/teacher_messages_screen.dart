import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'chat_screen.dart';

class TeacherMessagesScreen extends StatefulWidget {
  const TeacherMessagesScreen({super.key});

  @override
  State<TeacherMessagesScreen> createState() => _TeacherMessagesScreenState();
}

class _TeacherMessagesScreenState extends State<TeacherMessagesScreen> {
  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Principal',
      'role': 'Dr. Meera Kapoor',
      'lastMessage': 'Meeting at 3 PM today',
      'time': '10:30 AM',
      'unread': 1,
      'avatar': 'M',
      'online': true,
      'messages': [
        {'text': 'Good morning!', 'isMe': false, 'time': '10:15 AM'},
        {'text': 'Please attend the staff meeting at 3 PM today', 'isMe': false, 'time': '10:30 AM'},
      ],
    },
    {
      'name': 'Parent - Riya Sharma',
      'role': 'Mrs. Sharma',
      'lastMessage': 'Query about homework',
      'time': 'Yesterday',
      'unread': 2,
      'avatar': 'S',
      'online': false,
      'lastSeen': 'Yesterday at 5:30 PM',
      'messages': [
        {'text': 'Hello teacher, I have a question', 'isMe': false, 'time': 'Yesterday 4:00 PM'},
        {'text': 'About the homework assigned yesterday', 'isMe': false, 'time': 'Yesterday 4:05 PM'},
      ],
    },
    {
      'name': 'Parent - Aryan Kumar',
      'role': 'Mr. Kumar',
      'lastMessage': 'Thank you for the update',
      'time': '2 days ago',
      'unread': 0,
      'avatar': 'K',
      'online': false,
      'lastSeen': '2 days ago',
      'messages': [
        {'text': 'Aryan has improved in Math', 'isMe': true, 'time': '2 days ago 11:00 AM'},
        {'text': 'Thank you for the update', 'isMe': false, 'time': '2 days ago 2:00 PM'},
      ],
    },
    {
      'name': 'Teacher - Mr. Rajesh',
      'role': 'Science Teacher',
      'lastMessage': 'Can you substitute tomorrow?',
      'time': '3 days ago',
      'unread': 0,
      'avatar': 'R',
      'online': false,
      'lastSeen': '3 days ago',
      'messages': [
        {'text': 'Hi, I need a favor', 'isMe': false, 'time': '3 days ago 3:00 PM'},
        {'text': 'Can you substitute my class tomorrow?', 'isMe': false, 'time': '3 days ago 3:05 PM'},
        {'text': 'Sure, I can help', 'isMe': true, 'time': '3 days ago 4:00 PM'},
      ],
    },
    {
      'name': 'Admin Office',
      'role': 'Administration',
      'lastMessage': 'Submit attendance report',
      'time': '1 week ago',
      'unread': 0,
      'avatar': 'A',
      'online': false,
      'lastSeen': '1 week ago',
      'messages': [
        {'text': 'Please submit monthly attendance report', 'isMe': false, 'time': '1 week ago 5:00 PM'},
        {'text': 'Deadline is Friday', 'isMe': false, 'time': '1 week ago 5:01 PM'},
        {'text': 'Will submit by tomorrow', 'isMe': true, 'time': '1 week ago 6:00 PM'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                return _buildChatItem(_conversations[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
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
              Icons.chat_bubble_rounded,
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
                  'Your Conversations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_conversations.length} active chats',
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

  Widget _buildChatItem(Map<String, dynamic> chat) {
    final hasUnread = chat['unread'] > 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              name: chat['name'],
              role: chat['role'],
              avatar: chat['avatar'],
              online: chat['online'],
              lastSeen: chat['lastSeen'],
              messages: List<Map<String, dynamic>>.from(chat['messages']),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasUnread ? AppColors.primary.withOpacity(0.3) : const Color(0xFFF1F5F9),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    chat['avatar'],
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (chat['online'])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
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
                          chat['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        chat['time'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w500,
                          color: hasUnread ? AppColors.primary : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat['role'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['lastMessage'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                            color: hasUnread ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            chat['unread'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
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
      ),
    );
  }
}
