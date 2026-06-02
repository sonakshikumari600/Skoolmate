import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_colors.dart';
import 'user_provider.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  String _selectedClass = 'Class 8 - Section A';
  final Map<String, bool> _attendance = {};

  final List<String> _classes = [
    'Class 8 - Section A',
    'Class 8 - Section B',
    'Class 7 - Section A',
    'Class 6 - Section C',
    'Class 5 - Section B',
  ];

  final List<Map<String, String>> _students = [
    {'name': 'Aarav Sharma', 'roll': '01'},
    {'name': 'Diya Patel', 'roll': '02'},
    {'name': 'Arjun Kumar', 'roll': '03'},
    {'name': 'Ananya Singh', 'roll': '04'},
    {'name': 'Vihaan Gupta', 'roll': '05'},
    {'name': 'Isha Verma', 'roll': '06'},
    {'name': 'Reyansh Reddy', 'roll': '07'},
    {'name': 'Saanvi Nair', 'roll': '08'},
    {'name': 'Aditya Joshi', 'roll': '09'},
    {'name': 'Myra Desai', 'roll': '10'},
  ];

  @override
  void initState() {
    super.initState();
    for (var student in _students) {
      _attendance[student['roll']!] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final presentCount = _attendance.values.where((v) => v).length;
    final absentCount = _students.length - presentCount;

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
          'Take Attendance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(presentCount, absentCount),
          const SizedBox(height: 16),
          _buildClassSelector(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                return _buildStudentCard(_students[index]);
              },
            ),
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(int present, int absent) {
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
          Expanded(
            child: _buildHeaderStat(
              icon: Icons.check_circle_rounded,
              label: 'Present',
              value: present.toString(),
              color: const Color(0xFF10B981),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildHeaderStat(
              icon: Icons.cancel_rounded,
              label: 'Absent',
              value: absent.toString(),
              color: const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: DropdownButton<String>(
          value: _selectedClass,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
          items: _classes.map((className) {
            return DropdownMenuItem(
              value: className,
              child: Text(className),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _selectedClass = value!);
          },
        ),
      ),
    );
  }

  Widget _buildStudentCard(Map<String, String> student) {
    final roll = student['roll']!;
    final isPresent = _attendance[roll] ?? true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPresent
              ? const Color(0xFFD1FAE5)
              : const Color(0xFFFEE2E2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isPresent
                ? const Color(0xFFD1FAE5)
                : const Color(0xFFFEE2E2),
            child: Text(
              student['roll']!,
              style: TextStyle(
                color: isPresent
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Roll No: ${student['roll']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildAttendanceButton(
                label: 'P',
                isSelected: isPresent,
                color: const Color(0xFF10B981),
                onTap: () => setState(() => _attendance[roll] = true),
              ),
              const SizedBox(width: 8),
              _buildAttendanceButton(
                label: 'A',
                isSelected: !isPresent,
                color: const Color(0xFFEF4444),
                onTap: () => setState(() => _attendance[roll] = false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton({
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(18),
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final userProvider = Provider.of<UserProvider>(context, listen: false);
              final teacherId = userProvider.user?.uid;
              final teacherName = userProvider.userData?['name'] ?? 'Teacher';

              if (teacherId == null) return;

              try {
                final batch = FirebaseFirestore.instance.batch();
                final today = DateTime.now();
                final dateStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

                for (var student in _students) {
                  final roll = student['roll']!;
                  final isPresent = _attendance[roll] ?? true;
                  
                  final docRef = FirebaseFirestore.instance.collection('attendance').doc();
                  batch.set(docRef, {
                    'studentName': student['name'],
                    'studentRoll': roll,
                    'classId': _selectedClass,
                    'date': dateStr,
                    'status': isPresent ? 'present' : 'absent',
                    'markedBy': teacherId,
                    'markedByName': teacherName,
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                }

                await batch.commit();

                final presentCount = _attendance.values.where((v) => v).length;
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: Row(
                        children: const [
                          Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 28),
                          SizedBox(width: 12),
                          Text('Attendance Saved!'),
                        ],
                      ),
                      content: Text(
                        'Attendance for $_selectedClass has been saved to Firebase.\n\nPresent: $presentCount\nAbsent: ${_students.length - presentCount}',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: const Color(0xFFEF4444),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.save_rounded, color: Colors.white, size: 22),
                SizedBox(width: 10),
                Text(
                  'Save Attendance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
