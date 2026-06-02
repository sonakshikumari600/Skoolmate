import 'package:flutter/material.dart';

class TeacherFreePeriodsScreen extends StatelessWidget {
  const TeacherFreePeriodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Periods'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.free_breakfast, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Free Time Today', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          SizedBox(height: 4),
                          Text('You have 2 free periods today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Free Slots', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildFreeSlotCard('11:15 AM - 12:00 PM', 'Free Period 1', '45 minutes', Icons.coffee, Colors.orange),
            _buildFreeSlotCard('01:30 PM - 02:15 PM', 'Free Period 2', '45 minutes', Icons.coffee, Colors.orange),
            const SizedBox(height: 24),
            const Text('Suggested Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildTaskCard(context, 'Check Pending Assignments', 'Review and grade 5 pending submissions', Icons.assignment_turned_in, Colors.blue),
            _buildTaskCard(context, 'Prepare Next Class', 'Class 9B Mathematics - Algebra', Icons.book, Colors.purple),
            _buildTaskCard(context, 'Update Attendance', 'Mark attendance for morning classes', Icons.check_circle, Colors.green),
            _buildTaskCard(context, 'Reply to Messages', '3 unread messages from parents', Icons.message, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildFreeSlotCard(String time, String title, String duration, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(duration),
        trailing: Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening: $title'),
              backgroundColor: color,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
