import 'package:flutter/material.dart';
import 'app_colors.dart';

class StudentSubjectDetailScreen extends StatefulWidget {
  final Map<String, dynamic> subject;

  const StudentSubjectDetailScreen({super.key, required this.subject});

  @override
  State<StudentSubjectDetailScreen> createState() => _StudentSubjectDetailScreenState();
}

class _StudentSubjectDetailScreenState extends State<StudentSubjectDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FF),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildQuickStats(),
                _buildTabBar(),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotesTab(),
                _buildAssignmentsTab(),
                _buildAnnouncementsTab(),
                _buildExamScheduleTab(),
                _buildPerformanceTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: widget.subject['color'] as Color,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.subject['name'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.subject['color'] as Color,
                (widget.subject['color'] as Color).withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              widget.subject['icon'] as IconData,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: (widget.subject['color'] as Color).withOpacity(0.1),
                child: Text(
                  widget.subject['faculty'].toString().split(' ')[0][0],
                  style: TextStyle(
                    color: widget.subject['color'] as Color,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subject['faculty'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      widget.subject['code'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.email_outlined,
                color: widget.subject['color'] as Color,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  Icons.calendar_today,
                  'Attendance',
                  '${widget.subject['attendance']}%',
                  Colors.blue,
                ),
              ),
              Container(width: 1, height: 40, color: const Color(0xFFF1F5F9)),
              Expanded(
                child: _buildStatItem(
                  Icons.trending_up,
                  'Performance',
                  '${widget.subject['performance']}%',
                  Colors.green,
                ),
              ),
              Container(width: 1, height: 40, color: const Color(0xFFF1F5F9)),
              Expanded(
                child: _buildStatItem(
                  Icons.access_time,
                  'Next Class',
                  widget.subject['nextClass'].toString().split(',')[0],
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF64748B),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: widget.subject['color'] as Color,
        unselectedLabelColor: const Color(0xFF64748B),
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: (widget.subject['color'] as Color).withOpacity(0.1),
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Notes'),
          Tab(text: 'Assignments'),
          Tab(text: 'Announcements'),
          Tab(text: 'Exams'),
          Tab(text: 'Analytics'),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    final notes = [
      {'title': 'Chapter 5: Quadratic Equations', 'date': '2 days ago', 'pages': 8, 'icon': Icons.description},
      {'title': 'Algebra Formulas Reference', 'date': '5 days ago', 'pages': 4, 'icon': Icons.calculate},
      {'title': 'Geometry Theorems', 'date': '1 week ago', 'pages': 6, 'icon': Icons.square_foot},
      {'title': 'Trigonometry Basics', 'date': '2 weeks ago', 'pages': 10, 'icon': Icons.functions},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (widget.subject['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                note['icon'] as IconData,
                color: widget.subject['color'] as Color,
                size: 24,
              ),
            ),
            title: Text(
              note['title'] as String,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            subtitle: Text(
              '${note['pages']} pages • ${note['date']}',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
              ),
            ),
            trailing: Icon(Icons.download_rounded, color: widget.subject['color'] as Color),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening ${note['title']}'),
                  backgroundColor: widget.subject['color'] as Color,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAssignmentsTab() {
    final assignments = [
      {'title': 'Solve Exercise 5.3', 'due': 'Due Tomorrow', 'status': 'Pending', 'points': 20},
      {'title': 'Project: Real World Math', 'due': 'Due in 3 days', 'status': 'In Progress', 'points': 50},
      {'title': 'Quiz Preparation', 'due': 'Due in 1 week', 'status': 'Not Started', 'points': 30},
      {'title': 'Chapter 4 Problems', 'due': 'Submitted', 'status': 'Completed', 'points': 25},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        final isCompleted = assignment['status'] == 'Completed';
        Color statusColor = isCompleted ? Colors.green : Colors.orange;
        if (assignment['status'] == 'Pending') statusColor = Colors.red;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
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
                  Expanded(
                    child: Text(
                      assignment['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      assignment['status'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    assignment['due'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.star_outline, size: 14, color: Colors.amber.shade700),
                  const SizedBox(width: 4),
                  Text(
                    '${assignment['points']} pts',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnnouncementsTab() {
    final announcements = [
      {'title': 'Extra Class on Saturday', 'date': 'Today', 'priority': 'High'},
      {'title': 'Unit Test Scheduled', 'date': 'Yesterday', 'priority': 'Medium'},
      {'title': 'Study Material Uploaded', 'date': '3 days ago', 'priority': 'Low'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        Color priorityColor = Colors.green;
        if (announcement['priority'] == 'High') priorityColor = Colors.red;
        if (announcement['priority'] == 'Medium') priorityColor = Colors.orange;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: priorityColor.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.campaign_rounded, color: priorityColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      announcement['date'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.priority_high_rounded, color: priorityColor, size: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExamScheduleTab() {
    final exams = [
      {'name': 'Mid-Term Exam', 'date': 'Dec 25, 2024', 'time': '10:00 AM', 'duration': '2 hours', 'syllabus': 'Chapters 1-5'},
      {'name': 'Unit Test 3', 'date': 'Dec 20, 2024', 'time': '11:00 AM', 'duration': '1 hour', 'syllabus': 'Chapter 5'},
      {'name': 'Final Exam', 'date': 'Jan 15, 2025', 'time': '9:00 AM', 'duration': '3 hours', 'syllabus': 'Full Course'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: (widget.subject['color'] as Color).withOpacity(0.3), width: 1.5),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (widget.subject['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.quiz_rounded,
                      color: widget.subject['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      exam['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildExamDetail(Icons.calendar_today, exam['date'] as String),
              const SizedBox(height: 6),
              _buildExamDetail(Icons.access_time, '${exam['time']} • ${exam['duration']}'),
              const SizedBox(height: 6),
              _buildExamDetail(Icons.menu_book, exam['syllabus'] as String),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExamDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.subject['color'] as Color,
                  (widget.subject['color'] as Color).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (widget.subject['color'] as Color).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Overall Performance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.subject['performance']}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.trending_up_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '+5% from last month',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildPerformanceCard('Attendance', widget.subject['attendance'], Icons.calendar_today, Colors.blue),
          _buildPerformanceCard('Assignments', 85, Icons.assignment, Colors.orange),
          _buildPerformanceCard('Tests Average', 82, Icons.quiz, Colors.green),
          _buildPerformanceCard('Class Participation', 90, Icons.people, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String label, int value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: value / 100,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFF1F5F9),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$value%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: color,
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
