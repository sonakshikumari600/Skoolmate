import 'package:flutter/material.dart';

class TeacherClassesScreen extends StatelessWidget {
  const TeacherClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Classes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.school, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Classes Today', style: TextStyle(fontSize: 14, color: Colors.grey)),
                        SizedBox(height: 4),
                        Text('7 Classes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Today\'s Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildClassCard('09:00 AM - 09:45 AM', 'Class 10A', 'Mathematics', 'Room 201', Colors.blue),
            _buildClassCard('09:45 AM - 10:30 AM', 'Class 8B', 'Science', 'Room 105', Colors.green),
            _buildClassCard('10:30 AM - 11:15 AM', 'Class 10B', 'Mathematics', 'Room 202', Colors.blue),
            _buildClassCard('12:00 PM - 12:45 PM', 'Class 9A', 'Mathematics', 'Room 203', Colors.blue),
            _buildClassCard('12:45 PM - 01:30 PM', 'Class 7A', 'Science', 'Room 104', Colors.green),
            _buildClassCard('02:15 PM - 03:00 PM', 'Class 8A', 'Science', 'Room 106', Colors.green),
            _buildClassCard('03:00 PM - 03:45 PM', 'Class 9B', 'Mathematics', 'Room 204', Colors.blue),
            const SizedBox(height: 24),
            const Text('Subject-wise Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSubjectCard('Mathematics', 4, Colors.blue),
            _buildSubjectCard('Science', 3, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(String time, String className, String subject, String room, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.class_, color: color),
        ),
        title: Text(className, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$subject • $room'),
        trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }

  Widget _buildSubjectCard(String subject, int count, Color color) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text('$count', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$count classes today'),
      ),
    );
  }
}
