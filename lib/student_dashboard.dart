import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'student_timetable_screen.dart';
import 'student_homework_screen.dart';
import 'student_exams_screen.dart';
import 'student_attendance_screen.dart';
import 'student_notifications_screen.dart';
import 'student_profile_screen.dart';
import 'student_subject_overview_screen.dart';
import 'user_provider.dart';

// ── Dummy Data ─────────────────────────────────────────────────────────────────

class _TimetableItem {
  final String time;
  final String subject;
  const _TimetableItem(this.time, this.subject);
}

class _HomeworkItem {
  final String title;
  final String due;
  final bool urgent;
  const _HomeworkItem(this.title, this.due, {this.urgent = false});
}

const _timetable = [
  _TimetableItem('09:00 AM', 'Maths'),
  _TimetableItem('10:00 AM', 'Science'),
  _TimetableItem('11:00 AM', 'English'),
];

const _homework = [
  _HomeworkItem('Maths worksheet', 'Due Tomorrow', urgent: true),
  _HomeworkItem('Science project', 'Due Friday'),
];

const _exams = [
  {'subject': 'Maths Test', 'date': 'Monday'},
  {'subject': 'Science Test', 'date': 'Wednesday'},
];

// ── Student Dashboard ──────────────────────────────────────────────────────────

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildHeader(),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentTimetableScreen(),
                        ),
                      ),
                      child: _buildTimetableCard(),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Quick Stats'),
                    const SizedBox(height: 12),
                    _buildStatsGrid(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Homework'),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentHomeworkScreen(),
                        ),
                      ),
                      child: _buildHomeworkSection(),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Upcoming Exams'),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentExamsScreen(),
                        ),
                      ),
                      child: _buildExamsSection(),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Notifications'),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentNotificationsScreen(),
                        ),
                      ),
                      child: _buildNotifications(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Top Bar ────────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A56DB), Color(0xFF4A90E2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu_book_rounded,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Text(
            'SkoolMate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 26),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StudentNotificationsScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBBF24),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentProfileScreen(),
                ),
              );
            },
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final name = userProvider.userData?['name'] ?? 'S';
                final initials = name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();
                return CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider.userData?['name'] ?? 'Student';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '👋 Good Morning, $userName!',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Stay updated with your studies',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueGrey.shade400,
          ),
        ),
      ],
    );
  }

  // ── Timetable Card ─────────────────────────────────────────────────────────────

  Widget _buildTimetableCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A56DB), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.schedule_rounded, color: Colors.white70, size: 18),
              SizedBox(width: 8),
              Text(
                "Today's Timetable",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._timetable.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.time,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.subject,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ── Stats Grid ─────────────────────────────────────────────────────────────────

  Widget _buildStatsGrid() {
    final stats = [
      {'icon': Icons.calendar_month_rounded, 'label': 'Attend', 'value': '85%', 'screen': const StudentAttendanceScreen()},
      {'icon': Icons.assignment_rounded, 'label': 'Tasks', 'value': '3', 'screen': const StudentHomeworkScreen()},
      {'icon': Icons.quiz_rounded, 'label': 'Exams', 'value': '2', 'screen': const StudentExamsScreen()},
      {'icon': Icons.book_rounded, 'label': 'Subjects', 'value': '5', 'screen': const StudentSubjectOverviewScreen()},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3.5,
      ),
      itemCount: stats.length,
      itemBuilder: (_, i) {
        final s = stats[i];
        final screen = s['screen'] as Widget?;
        return GestureDetector(
          onTap: screen != null
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => screen,
                    ),
                  )
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                Icon(s['icon'] as IconData,
                    color: AppColors.primary, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s['value'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B),
                          height: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        s['label'] as String,
                        style: const TextStyle(
                          fontSize: 7,
                          color: Color(0xFF64748B),
                          height: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Homework Section ───────────────────────────────────────────────────────────

  Widget _buildHomeworkSection() {
    return Container(
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
      child: Column(
        children: List.generate(_homework.length, (i) {
          final hw = _homework[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: hw.urgent
                            ? const Color(0xFFFEE2E2)
                            : const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.assignment_outlined,
                        color: hw.urgent
                            ? const Color(0xFFEF4444)
                            : AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hw.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 12,
                                color: hw.urgent
                                    ? const Color(0xFFEF4444)
                                    : const Color(0xFF94A3B8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                hw.due,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: hw.urgent
                                      ? const Color(0xFFEF4444)
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (hw.urgent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Urgent',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (i < _homework.length - 1)
                Divider(
                  height: 1,
                  indent: 70,
                  endIndent: 16,
                  color: const Color(0xFFF1F5F9),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ── Exams Section ──────────────────────────────────────────────────────────────

  Widget _buildExamsSection() {
    return Container(
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
      child: Column(
        children: List.generate(_exams.length, (i) {
          final exam = _exams[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.quiz_rounded,
                        color: Color(0xFF6366F1),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam['subject'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            exam['date'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: Color(0xFFCBD5E1)),
                  ],
                ),
              ),
              if (i < _exams.length - 1)
                Divider(
                  height: 1,
                  indent: 70,
                  endIndent: 16,
                  color: const Color(0xFFF1F5F9),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ── Notifications ──────────────────────────────────────────────────────────────

  Widget _buildNotifications() {
    final notifs = [
      {'icon': Icons.check_circle_rounded, 'text': 'Homework submitted successfully', 'color': const Color(0xFF10B981)},
      {'icon': Icons.add_circle_rounded, 'text': 'New assignment added', 'color': const Color(0xFF3B82F6)},
    ];

    return Container(
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
      child: Column(
        children: List.generate(notifs.length, (i) {
          final n = notifs[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (n['color'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(n['icon'] as IconData,
                          color: n['color'] as Color, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        n['text'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < notifs.length - 1)
                Divider(
                  height: 1,
                  indent: 70,
                  endIndent: 16,
                  color: const Color(0xFFF1F5F9),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ── Section Label ──────────────────────────────────────────────────────────────

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

  // ── Bottom Navigation ──────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    const items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.schedule_rounded, 'label': 'Timetable'},
      {'icon': Icons.assignment_rounded, 'label': 'Homework'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = _bottomIndex == i;
              return GestureDetector(
                onTap: () {
                  if (i == 0) {
                    // Home - stay on current screen
                    setState(() => _bottomIndex = 0);
                  } else if (i == 1) {
                    // Timetable
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudentTimetableScreen(),
                      ),
                    );
                  } else if (i == 2) {
                    // Homework
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudentHomeworkScreen(),
                      ),
                    );
                  } else if (i == 3) {
                    // Profile
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudentProfileScreen(),
                      ),
                    );
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withOpacity(0.10)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[i]['icon'] as IconData,
                        color: selected
                            ? AppColors.primary
                            : const Color(0xFF94A3B8),
                        size: 22,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[i]['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: selected
                              ? AppColors.primary
                              : const Color(0xFF94A3B8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
