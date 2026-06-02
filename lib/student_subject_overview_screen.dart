import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'user_provider.dart';
import 'student_subject_detail_screen.dart';

class StudentSubjectOverviewScreen extends StatefulWidget {
  const StudentSubjectOverviewScreen({super.key});

  @override
  State<StudentSubjectOverviewScreen> createState() => _StudentSubjectOverviewScreenState();
}

class _StudentSubjectOverviewScreenState extends State<StudentSubjectOverviewScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _subjects = [
    {
      'name': 'Mathematics',
      'faculty': 'Mr. Rajesh Kumar',
      'icon': Icons.calculate_rounded,
      'color': const Color(0xFF3B82F6),
      'code': 'MATH-101',
      'credits': 4,
      'attendance': 88,
      'performance': 85,
      'assignments': 3,
      'notes': 12,
      'nextClass': 'Tomorrow, 9:00 AM',
      'category': 'Core',
    },
    {
      'name': 'Science',
      'faculty': 'Dr. Anjali Verma',
      'icon': Icons.science_rounded,
      'color': const Color(0xFF10B981),
      'code': 'SCI-101',
      'credits': 4,
      'attendance': 92,
      'performance': 78,
      'assignments': 2,
      'notes': 15,
      'nextClass': 'Today, 2:00 PM',
      'category': 'Core',
    },
    {
      'name': 'English',
      'faculty': 'Ms. Priya Sharma',
      'icon': Icons.book_rounded,
      'color': const Color(0xFF6366F1),
      'code': 'ENG-101',
      'credits': 3,
      'attendance': 90,
      'performance': 82,
      'assignments': 1,
      'notes': 10,
      'nextClass': 'Mon, 11:00 AM',
      'category': 'Core',
    },
    {
      'name': 'History',
      'faculty': 'Mr. Vikram Singh',
      'icon': Icons.history_edu_rounded,
      'color': const Color(0xFFF59E0B),
      'code': 'HIS-101',
      'credits': 3,
      'attendance': 85,
      'performance': 75,
      'assignments': 2,
      'notes': 8,
      'nextClass': 'Tue, 2:00 PM',
      'category': 'Elective',
    },
    {
      'name': 'Geography',
      'faculty': 'Mrs. Meera Kapoor',
      'icon': Icons.public_rounded,
      'color': const Color(0xFF8B5CF6),
      'code': 'GEO-101',
      'credits': 3,
      'attendance': 87,
      'performance': 80,
      'assignments': 1,
      'notes': 9,
      'nextClass': 'Wed, 1:00 PM',
      'category': 'Elective',
    },
    {
      'name': 'Physical Education',
      'faculty': 'Mr. Arjun Patel',
      'icon': Icons.sports_soccer_rounded,
      'color': const Color(0xFFEF4444),
      'code': 'PE-101',
      'credits': 2,
      'attendance': 95,
      'performance': 90,
      'assignments': 0,
      'notes': 5,
      'nextClass': 'Mon, 3:00 PM',
      'category': 'Extra',
    },
    {
      'name': 'Computer Science',
      'faculty': 'Ms. Neha Gupta',
      'icon': Icons.computer_rounded,
      'color': const Color(0xFF06B6D4),
      'code': 'CS-101',
      'credits': 4,
      'attendance': 91,
      'performance': 88,
      'assignments': 4,
      'notes': 18,
      'nextClass': 'Thu, 11:00 AM',
      'category': 'Core',
    },
    {
      'name': 'Art & Craft',
      'faculty': 'Mrs. Pooja Reddy',
      'icon': Icons.palette_rounded,
      'color': const Color(0xFFEC4899),
      'code': 'ART-101',
      'credits': 2,
      'attendance': 93,
      'performance': 86,
      'assignments': 1,
      'notes': 6,
      'nextClass': 'Fri, 2:00 PM',
      'category': 'Extra',
    },
  ];

  List<String> get _filters => ['All', 'Core', 'Elective', 'Extra'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredSubjects {
    return _subjects.where((subject) {
      final matchesSearch = subject['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject['faculty'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject['code'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesFilter = _selectedFilter == 'All' || subject['category'] == _selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

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
          'My Subjects',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildFilterChips(),
            _buildStatsRow(),
            Expanded(
              child: _filteredSubjects.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: _filteredSubjects.length,
                      itemBuilder: (context, index) {
                        return _buildSubjectCard(_filteredSubjects[index], index);
                      },
                    ),
            ),
          ],
        ),
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
              Icons.library_books_rounded,
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
                  'Enrolled Subjects',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_subjects.length} subjects • ${_subjects.fold(0, (sum, s) => sum + (s['credits'] as int))} credits',
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search subjects or faculty...',
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, color: Color(0xFF94A3B8)),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter);
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsRow() {
    final avgAttendance = _subjects.fold(0, (sum, s) => sum + (s['attendance'] as int)) ~/ _subjects.length;
    final avgPerformance = _subjects.fold(0, (sum, s) => sum + (s['performance'] as int)) ~/ _subjects.length;
    final totalAssignments = _subjects.fold(0, (sum, s) => sum + (s['assignments'] as int));

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
      child: Row(
        children: [
          Expanded(child: _buildStatBox('Attendance', '$avgAttendance%', Icons.calendar_today, Colors.blue)),
          const SizedBox(width: 10),
          Expanded(child: _buildStatBox('Performance', '$avgPerformance%', Icons.trending_up, Colors.green)),
          const SizedBox(width: 10),
          Expanded(child: _buildStatBox('Pending', '$totalAssignments', Icons.assignment, Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No subjects found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value.clamp(0.0, 1.0),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StudentSubjectDetailScreen(subject: subject),
            ),
          );
        },
        child: Hero(
          tag: 'subject_${subject['code']}',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  subject['color'] as Color,
                  (subject['color'] as Color).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (subject['color'] as Color).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            subject['icon'] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${subject['credits']} CR',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      subject['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subject['faculty'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Flexible(
                          child: _buildCardStat(Icons.assignment_outlined, '${subject['assignments']}'),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: _buildCardStat(Icons.trending_up_rounded, '${subject['performance']}%'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardStat(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: Colors.white),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
