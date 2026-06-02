import 'package:flutter/material.dart';
import 'app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
          'Terms & Conditions',
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
                    'Acceptance of Terms',
                    'By accessing and using SkoolMate application, you accept and agree to be bound by the terms and provisions of this agreement. If you do not agree to these terms, please do not use this application.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'User Eligibility',
                    'SkoolMate is intended for use by:\n\n• Students enrolled in registered educational institutions\n• Parents/guardians of enrolled students\n• Teachers and staff employed by registered schools\n• School administrators with proper authorization\n\nUsers must be at least 13 years old or have parental consent to use this application. By using SkoolMate, you represent that you meet these eligibility requirements.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'User Account Responsibilities',
                    'When you create an account with us, you agree to:\n\n• Provide accurate, current, and complete information\n• Maintain the security of your password and account\n• Notify us immediately of any unauthorized access\n• Accept responsibility for all activities under your account\n• Not share your account credentials with others\n• Not create multiple accounts for the same user\n• Not impersonate another person or entity',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Acceptable Use Policy',
                    'You agree NOT to use SkoolMate to:\n\n• Violate any laws or regulations\n• Harass, abuse, or harm other users\n• Post inappropriate, offensive, or harmful content\n• Share false or misleading information\n• Distribute spam or unsolicited messages\n• Upload viruses or malicious code\n• Attempt to gain unauthorized access to the system\n• Interfere with the proper functioning of the app\n• Use automated systems to access the service\n• Collect user data without permission',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Content Guidelines',
                    'Users are responsible for all content they post, including:\n\n• Homework submissions and assignments\n• Messages and communications\n• Profile information and photos\n• Comments and feedback\n\nWe reserve the right to remove any content that violates these terms or is deemed inappropriate. Content must be:\n\n• Respectful and appropriate for an educational environment\n• Accurate and truthful\n• Free from copyright infringement\n• Compliant with school policies',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Intellectual Property Rights',
                    'SkoolMate and its original content, features, and functionality are owned by SkoolMate Technologies and are protected by:\n\n• International copyright laws\n• Trademark laws\n• Patent laws\n• Other intellectual property rights\n\nYou may not copy, modify, distribute, sell, or lease any part of our services without explicit written permission.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Service Availability',
                    'We strive to provide uninterrupted service, but we do not guarantee:\n\n• Continuous, uninterrupted access to the app\n• Error-free operation\n• Freedom from viruses or harmful components\n• Accuracy of information provided\n\nWe reserve the right to:\n\n• Modify or discontinue services at any time\n• Perform scheduled maintenance\n• Update features and functionality\n• Change these terms with notice to users',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Academic Integrity',
                    'Students and teachers must maintain academic honesty:\n\n• Students must submit original work\n• Plagiarism is strictly prohibited\n• Cheating or academic dishonesty may result in account suspension\n• Teachers must provide fair and unbiased assessments\n• All academic records must be accurate and truthful',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Communication Standards',
                    'All communications through SkoolMate must be:\n\n• Professional and respectful\n• Relevant to educational purposes\n• Appropriate for the school environment\n• Free from harassment or bullying\n• Compliant with school communication policies\n\nParents, teachers, and students should use the messaging features responsibly and maintain appropriate boundaries.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Limitation of Liability',
                    'SkoolMate Technologies shall not be liable for:\n\n• Any indirect, incidental, or consequential damages\n• Loss of data or information\n• Service interruptions or errors\n• Actions of other users\n• Third-party content or links\n• Decisions made based on app information\n\nYour use of the service is at your own risk. The service is provided "as is" without warranties of any kind.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Termination',
                    'We may terminate or suspend your account immediately, without prior notice, for:\n\n• Violation of these Terms & Conditions\n• Fraudulent or illegal activities\n• Abuse of the service or other users\n• Extended periods of inactivity\n• Request from school administration\n\nUpon termination:\n\n• Your right to use the service will cease immediately\n• You must stop using the application\n• We may delete your account and data\n• Certain provisions of these terms will survive termination',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Dispute Resolution',
                    'Any disputes arising from these terms shall be:\n\n• First attempted to be resolved through good faith negotiation\n• Subject to mediation if negotiation fails\n• Governed by the laws of India\n• Subject to the exclusive jurisdiction of courts in New Delhi, India\n\nYou agree to resolve disputes individually and waive any right to class action proceedings.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Changes to Terms',
                    'We reserve the right to modify these terms at any time. We will:\n\n• Notify users of significant changes via email or app notification\n• Post the updated terms in the application\n• Update the "Last Updated" date\n\nContinued use of SkoolMate after changes constitutes acceptance of the new terms.',
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Contact Information',
                    'For questions about these Terms & Conditions, contact us:\n\nEmail: legal@skoolmate.com\nPhone: +91 9876543210\nAddress: SkoolMate Technologies\nConnaught Place, New Delhi, India - 110001\n\nBusiness Hours: Monday - Friday, 9:00 AM - 6:00 PM IST',
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
              Icons.description_outlined,
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
                  'Terms & Conditions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Please read carefully',
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
