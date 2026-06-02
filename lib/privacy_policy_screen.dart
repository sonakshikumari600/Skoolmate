import 'package:flutter/material.dart';
import 'app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
                  _buildSection(
                    'Introduction',
                    'Welcome to SkoolMate. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you about how we look after your personal data when you use our app and tell you about your privacy rights.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Information We Collect',
                    'We collect and process the following types of information:\n\n• Personal identification information (Name, email address, phone number)\n• Academic information (Class, roll number, grades)\n• Attendance records\n• Assignment and homework submissions\n• Communication between parents and teachers\n• Device information and app usage data',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'How We Use Your Information',
                    'We use your information to:\n\n• Provide and maintain our educational services\n• Notify you about changes to our service\n• Provide customer support\n• Monitor and analyze usage patterns\n• Detect and prevent technical issues\n• Send important updates about academic activities\n• Facilitate communication between parents, teachers, and students',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Data Security',
                    'We implement appropriate security measures to protect your personal information. Your data is stored on secure servers with encryption. We regularly review our security procedures to ensure the safety of your information.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Data Sharing',
                    'We do not sell, trade, or rent your personal information to third parties. We may share your information with:\n\n• School administrators and teachers (for educational purposes)\n• Parents/guardians (for student information)\n• Service providers who assist in app operations\n• Legal authorities when required by law',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Your Rights',
                    'You have the right to:\n\n• Access your personal data\n• Correct inaccurate data\n• Request deletion of your data\n• Object to data processing\n• Request data portability\n• Withdraw consent at any time',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Children\'s Privacy',
                    'Our service is designed for use by students, parents, and educational institutions. We take special care to protect children\'s privacy and comply with applicable laws regarding children\'s online privacy.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Changes to This Policy',
                    'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Contact Us',
                    'If you have any questions about this Privacy Policy, please contact us:\n\nEmail: privacy@skoolmate.com\nPhone: +91 9876543210\nAddress: SkoolMate Technologies, New Delhi, India',
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.info_rounded, color: AppColors.primary, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Last Updated: December 20, 2024',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              Icons.lock_outline_rounded,
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
                  'Your Privacy Matters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Read how we protect your data',
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

  Widget _buildSection(String title, String content) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
