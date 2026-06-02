import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'attendance_details_screen.dart';
import 'marks_screen.dart';
import 'homework_screen.dart';
import 'timetable_screen.dart';
import 'fees_screen.dart';
import 'ptm_details_screen.dart';
import 'sports_event_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';
import 'user_provider.dart';

// ── Dummy Data Models ──────────────────────────────────────────────────────────

class _Child {
  final String name;
  final String grade;
  final String avatar;
  final _Stats stats;
  const _Child({
    required this.name,
    required this.grade,
    required this.avatar,
    required this.stats,
  });
}

class _Stats {
  final double attendance;
  final double average;
  final int pendingHomework;
  final int classesToday;
  final double feesDue;
  const _Stats({
    required this.attendance,
    required this.average,
    required this.pendingHomework,
    required this.classesToday,
    required this.feesDue,
  });
}

const _children = [
  _Child(
    name: 'Riya',
    grade: 'Class 5',
    avatar: 'R',
    stats: _Stats(
      attendance: 0.85,
      average: 78,
      pendingHomework: 2,
      classesToday: 6,
      feesDue: 5000,
    ),
  ),
  _Child(
    name: 'Aryan',
    grade: 'Class 8',
    avatar: 'A',
    stats: _Stats(
      attendance: 0.91,
      average: 83,
      pendingHomework: 1,
      classesToday: 7,
      feesDue: 0,
    ),
  ),
];

const _notifications = [
  _Notif(
    icon: Icons.event_note_rounded,
    color: Color(0xFF3B82F6),
    title: 'PTM scheduled on Friday',
    time: '2 hrs ago',
  ),
  _Notif(
    icon: Icons.check_circle_outline_rounded,
    color: Color(0xFF10B981),
    title: 'Math homework submitted',
    time: 'Yesterday',
  ),
  _Notif(
    icon: Icons.campaign_rounded,
    color: Color(0xFF6366F1),
    title: 'Annual Sports Day on Dec 20',
    time: '2 days ago',
  ),
  _Notif(
    icon: Icons.payment_rounded,
    color: Color(0xFFF59E0B),
    title: 'Fee reminder: Due by Dec 31',
    time: '3 days ago',
  ),
];

class _Notif {
  final IconData icon;
  final Color color;
  final String title;
  final String time;
  const _Notif(
      {required this.icon,
      required this.color,
      required this.title,
      required this.time});
}

// ── Parent Dashboard ───────────────────────────────────────────────────────────

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  int _selectedChild = 0;
  int _bottomIndex = 0;

  _Child get _child => _children[_selectedChild];

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
                    const SizedBox(height: 20),
                    _buildChildSelector(),
                    const SizedBox(height: 24),
                    _buildSectionLabel('Dashboard Overview'),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AttendanceDetailsScreen(
                            childName: _child.name,
                            grade: _child.grade,
                            attendancePercentage: _child.stats.attendance,
                          ),
                        ),
                      ),
                      child: _buildAttendanceCard(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MarksScreen(
                                  childName: _child.name,
                                  averageMarks: _child.stats.average,
                                ),
                              ),
                            ),
                            child: _buildSmallCard(
                              icon: Icons.bar_chart_rounded,
                              iconColor: const Color(0xFF6366F1),
                              iconBg: const Color(0xFFEDE9FE),
                              label: 'Avg Marks',
                              value: '${_child.stats.average.toInt()}%',
                              sub: 'This term',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeworkScreen(
                                  childName: _child.name,
                                  pendingCount: _child.stats.pendingHomework,
                                ),
                              ),
                            ),
                            child: _buildSmallCard(
                              icon: Icons.assignment_outlined,
                              iconColor: const Color(0xFFF59E0B),
                              iconBg: const Color(0xFFFEF3C7),
                              label: 'Homework',
                              value: '${_child.stats.pendingHomework} Pending',
                              sub: 'Assignments',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TimetableScreen(
                                  childName: _child.name,
                                  classesToday: _child.stats.classesToday,
                                ),
                              ),
                            ),
                            child: _buildSmallCard(
                              icon: Icons.schedule_rounded,
                              iconColor: const Color(0xFF10B981),
                              iconBg: const Color(0xFFD1FAE5),
                              label: 'Timetable',
                              value: '${_child.stats.classesToday} Classes',
                              sub: 'Today',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FeesScreen(
                                  childName: _child.name,
                                  feesDue: _child.stats.feesDue,
                                ),
                              ),
                            ),
                            child: _buildSmallCard(
                              icon: Icons.receipt_long_rounded,
                              iconColor: _child.stats.feesDue > 0
                                  ? const Color(0xFFEF4444)
                                  : const Color(0xFF10B981),
                              iconBg: _child.stats.feesDue > 0
                                  ? const Color(0xFFFEE2E2)
                                  : const Color(0xFFD1FAE5),
                              label: 'Fees',
                              value: _child.stats.feesDue > 0
                                  ? '₹${_child.stats.feesDue.toInt()}'
                                  : 'Paid ✓',
                              sub: _child.stats.feesDue > 0 ? 'Due' : 'No dues',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionLabel('Performance Overview'),
                    const SizedBox(height: 14),
                    _buildPerformanceOverview(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Upcoming Events'),
                    const SizedBox(height: 14),
                    _buildUpcomingEvents(),
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

  // ── Top App Bar ──────────────────────────────────────────────────────────────

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
                      builder: (_) => const NotificationsScreen(),
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
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final name = userProvider.userData?['name'] ?? 'P';
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

  // ── Header ───────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider.userData?['name'] ?? 'Parent';
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '👋 Good Morning, $userName!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                'Welcome to SkoolMate',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey.shade400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFDBEAFE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.calendar_today_rounded,
                  size: 12, color: AppColors.primary),
              SizedBox(width: 4),
              Text(
                'Dec 16',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Child Selector ───────────────────────────────────────────────────────────

  Widget _buildChildSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Select Child'),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_children.length, (i) {
            final child = _children[i];
            final selected = _selectedChild == i;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedChild = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(right: i < _children.length - 1 ? 12 : 0),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: selected
                            ? AppColors.primary.withOpacity(0.28)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: selected ? 16 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: selected
                            ? Colors.white.withOpacity(0.25)
                            : const Color(0xFFDBEAFE),
                        child: Text(
                          child.avatar,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                            color: selected
                                ? Colors.white
                                : AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          child.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: selected
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ── Attendance Card ──────────────────────────────────────────────────────────

  Widget _buildAttendanceCard() {
    final pct = _child.stats.attendance;
    final color = pct >= 0.85
        ? const Color(0xFF10B981)
        : pct >= 0.70
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444);

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month_rounded,
                        color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        'Attendance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${(pct * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.25),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  pct >= 0.85
                      ? 'Excellent!'
                      : pct >= 0.70
                          ? 'Improve'
                          : 'Critical',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Circular indicator
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: pct,
                  strokeWidth: 7,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
                Center(
                  child: Text(
                    '${(pct * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Small Stat Card ──────────────────────────────────────────────────────────

  Widget _buildSmallCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 11, color: Color(0xFFCBD5E1)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF94A3B8),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ── Performance Overview ────────────────────────────────────────────────────

  Widget _buildPerformanceOverview() {
    final performance = [
      {
        'label': 'Attendance',
        'value': '${(_child.stats.attendance * 100).toInt()}%',
        'progress': _child.stats.attendance,
        'icon': Icons.calendar_today_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'label': 'Average Marks',
        'value': '${_child.stats.average.toInt()}%',
        'progress': _child.stats.average / 100,
        'icon': Icons.bar_chart_rounded,
        'color': const Color(0xFF6366F1),
      },
      {
        'label': 'Homework Completion',
        'value': '90%',
        'progress': 0.90,
        'icon': Icons.assignment_turned_in_rounded,
        'color': const Color(0xFF10B981),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
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
        children: List.generate(performance.length, (i) {
          final item = performance[i];
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                item['label'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF64748B),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              item['value'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: item['color'] as Color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: item['progress'] as double,
                            minHeight: 8,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                item['color'] as Color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (i < performance.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    height: 1,
                    color: Color(0xFFF1F5F9),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ── Upcoming Events ──────────────────────────────────────────────────────────

  Widget _buildUpcomingEvents() {
    final events = [
      {
        'title': 'PTM scheduled on Friday',
        'date': 'Dec 20, 2024',
        'icon': Icons.event_note_rounded,
        'color': const Color(0xFF3B82F6),
        'badge': 'This Week',
        'screen': const PTMDetailsScreen(),
      },
      {
        'title': 'Annual Sports Day',
        'date': 'Dec 20, 2024',
        'icon': Icons.sports_soccer_rounded,
        'color': const Color(0xFF10B981),
        'badge': 'Upcoming',
        'screen': const SportsEventScreen(),
      },
      {
        'title': 'Fee Due',
        'date': 'Dec 31, 2024',
        'icon': Icons.payment_rounded,
        'color': const Color(0xFFEF4444),
        'badge': 'Important',
        'screen': FeesScreen(
          childName: _child.name,
          feesDue: _child.stats.feesDue,
        ),
      },
    ];

    return Column(
      children: events.map((event) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => event['screen'] as Widget,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: (event['color'] as Color).withOpacity(0.2),
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
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        event['color'] as Color,
                        (event['color'] as Color).withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    event['icon'] as IconData,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12,
                            color: event['color'] as Color,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              event['date'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: event['color'] as Color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    event['badge'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Section Label ────────────────────────────────────────────────────────────

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

  // ── Bottom Navigation ────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    const items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.calendar_month_rounded, 'label': 'Attendance'},
      {'icon': Icons.chat_bubble_outline_rounded, 'label': 'Messages'},
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
                  if (i == 1) {
                    // Attendance tab
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AttendanceDetailsScreen(
                          childName: _child.name,
                          grade: _child.grade,
                          attendancePercentage: _child.stats.attendance,
                        ),
                      ),
                    );
                  } else if (i == 2) {
                    // Messages tab
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MessagesScreen(),
                      ),
                    );
                  } else if (i == 3) {
                    // Profile tab
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfileScreen(),
                      ),
                    );
                  } else {
                    setState(() => _bottomIndex = i);
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
