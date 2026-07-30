import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/assignment.dart';

class AssessmentsView extends StatelessWidget {
  const AssessmentsView({Key? key}) : super(key: key);

  String? _courseName(String courseId) {
    try {
      return dummyCourses.firstWhere((c) => c.id == courseId).code;
    } catch (_) {
      return null;
    }
  }

  Color _statusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.notSubmitted:
        return moodleTextMuted;
      case AssignmentStatus.submitted:
        return moodleBlue;
      case AssignmentStatus.graded:
        return const Color(0xFF2E7D32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sorted = List<Assignment>.from(dummyAssignments)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return Scaffold(
      backgroundColor: moodleBg,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          const Text(
            'Assessments',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 16),
          ...sorted.map((assignment) {
            final chipColor = _statusColor(assignment.status);
            return Card(
              color: moodleWhite,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: moodleBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  assignment.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: moodleTextDark,
                  ),
                ),
                subtitle: Text(
                  '${_courseName(assignment.courseId) ?? 'Module'} · Due ${_formatDate(assignment.dueDate)}',
                  style: const TextStyle(color: moodleTextMuted),
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: chipColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    assignment.statusLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: chipColor,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
