import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/assignment.dart';

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({
    Key? key,
    required this.assignment,
  }) : super(key: key);

  final Assignment assignment;

  Color get _statusColor {
    switch (assignment.status) {
      case AssignmentStatus.notStarted:
        return moodleTextMuted;
      case AssignmentStatus.inProgress:
        return moodleBlue;
      case AssignmentStatus.submitted:
        return const Color(0xFF2E7D32);
      case AssignmentStatus.overdue:
        return const Color(0xFFC62828);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dueLabel = _formatDueDate(assignment.dueDate);

    return Card(
      color: moodleWhite,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: moodleGrayBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    assignment.courseCode,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: moodlePurple,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    assignment.statusLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              assignment.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: moodleTextDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              assignment.description,
              style: const TextStyle(fontSize: 14, color: moodleTextMuted),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.event, size: 16, color: moodleTextMuted),
                const SizedBox(width: 6),
                Text(
                  'Due $dueLabel',
                  style: const TextStyle(fontSize: 13, color: moodleTextMuted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDueDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${months[date.month - 1]} ${date.year}, $hour:$minute';
  }
}
