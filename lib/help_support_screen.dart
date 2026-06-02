import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'contact_us_screen.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _expandedIndex;

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
          'Help & Support',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('Quick Help'),
                  const SizedBox(height: 12),
                  _buildQuickHelpCards(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Frequently Asked Questions'),
                  const SizedBox(height: 12),
                  _buildFAQSection(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Troubleshooting'),
                  const SizedBox(height: 12),
                  _buildTroubleshootingSection(),
                  const SizedBox(height: 24),
                  _buildContactSupportButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
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
              Icons.help_outline_rounded,
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
                  'How Can We Help?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Find answers and guidance',
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

  Widget _buildQuickHelpCards() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickHelpCard(
            icon: Icons.book_outlined,
            title: 'User Guide',
            color: const Color(0xFF3B82F6),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening user guide...')),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickHelpCard(
            icon: Icons.video_library_outlined,
            title: 'Video Tutorials',
            color: const Color(0xFFEF4444),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening video tutorials...')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickHelpCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    final faqs = [
      {
        'question': 'How do I reset my password?',
        'answer': 'Go to Profile > Settings > Change Password. Enter your current password and new password, then click Save. You can also use "Forgot Password" on the login screen to reset via email.',
      },
      {
        'question': 'How do I check my attendance?',
        'answer': 'Students: Go to Dashboard > Attendance to view your attendance records.\nParents: Navigate to Dashboard > Child\'s Attendance to see your child\'s attendance.\nTeachers: Access Teacher Dashboard > Attendance to mark and view attendance.',
      },
      {
        'question': 'How do I submit homework?',
        'answer': 'Go to Homework section from the dashboard, select the assignment, attach your files or write your answer, and click Submit. You\'ll receive a confirmation once submitted successfully.',
      },
      {
        'question': 'How do I view my exam results?',
        'answer': 'Navigate to Dashboard > Exams/Marks section. Select the exam to view detailed results including subject-wise marks, grades, and overall performance.',
      },
      {
        'question': 'How do I communicate with teachers?',
        'answer': 'Use the Messages feature from the dashboard. Select the teacher you want to contact, type your message, and send. Teachers will respond through the same platform.',
      },
      {
        'question': 'How do I update my profile information?',
        'answer': 'Go to Profile screen, tap the Edit button in the top right corner, update your information (name, email, phone, address), and tap Save to confirm changes.',
      },
      {
        'question': 'How do I enable/disable notifications?',
        'answer': 'Go to Settings > Notifications. Toggle the switches for different notification types (Push, Email, SMS) based on your preferences.',
      },
      {
        'question': 'How do I apply for leave?',
        'answer': 'Parents: Go to Dashboard > Apply Leave, select dates, choose leave type, enter reason, and submit.\nStudents: Request your parent to apply leave through their account.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(faqs.length, (index) {
          final faq = faqs[index];
          final isExpanded = _expandedIndex == index;
          return Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.help_outline_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          faq['question']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(56, 0, 16, 16),
                  child: Text(
                    faq['answer']!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              if (index < faqs.length - 1)
                const Divider(height: 1, indent: 56, endIndent: 16),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTroubleshootingSection() {
    final issues = [
      {
        'icon': Icons.wifi_off_rounded,
        'title': 'Connection Issues',
        'solution': 'Check your internet connection. Try switching between WiFi and mobile data. Restart the app if the problem persists.',
        'color': const Color(0xFFEF4444),
      },
      {
        'icon': Icons.login_rounded,
        'title': 'Login Problems',
        'solution': 'Ensure you\'re using the correct credentials. Use "Forgot Password" to reset. Clear app cache in Settings if needed.',
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.notifications_off_rounded,
        'title': 'Not Receiving Notifications',
        'solution': 'Enable notifications in Settings > Notifications. Check device notification permissions for SkoolMate in phone settings.',
        'color': const Color(0xFF3B82F6),
      },
      {
        'icon': Icons.slow_motion_video_rounded,
        'title': 'App Running Slow',
        'solution': 'Clear cache from Settings > Preferences > Clear Cache. Close other apps running in background. Update to latest version.',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'icon': Icons.file_upload_outlined,
        'title': 'File Upload Failed',
        'solution': 'Check file size (max 10MB). Ensure stable internet connection. Try uploading in a different format (PDF, JPG, PNG).',
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.sync_problem_rounded,
        'title': 'Data Not Syncing',
        'solution': 'Pull down to refresh the screen. Check internet connection. Log out and log back in to force sync.',
        'color': const Color(0xFF06B6D4),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(issues.length, (index) {
          final issue = issues[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (issue['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        issue['icon'] as IconData,
                        color: issue['color'] as Color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            issue['title'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            issue['solution'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (index < issues.length - 1)
                const Divider(height: 1, indent: 60, endIndent: 16),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContactSupportButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.support_agent_rounded, color: Colors.white, size: 40),
          const SizedBox(height: 12),
          const Text(
            'Still Need Help?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Our support team is here to assist you',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF10B981), size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Contact Support',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
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
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
