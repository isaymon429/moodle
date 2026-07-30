import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class AssessmentsView extends StatefulWidget {
  const AssessmentsView({Key? key}) : super(key: key);

  @override
  State<AssessmentsView> createState() => _AssessmentsViewState();
}

class _AssessmentsViewState extends State<AssessmentsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AssignmentProvider>().loadAssignments();
      context.read<CourseProvider>().loadCourses();
    });
  }

  String? _courseCode(List<Course> courses, String courseId) {
    try {
      return courses.firstWhere((c) => c.id == courseId).code;
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
    final assignments = context.watch<AssignmentProvider>().assignments;
    final courses = context.watch<CourseProvider>().courses;
    final isLoading = context.watch<AssignmentProvider>().isLoading;

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Assessments'),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Assessments',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: moodlePurple,
                  ),
                ),
                const SizedBox(height: 16),
                ...assignments.map((assignment) {
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
                        '${_courseCode(courses, assignment.courseId) ?? 'Module'} · Due ${_formatDate(assignment.dueDate)}',
                        style: const TextStyle(color: moodleTextMuted),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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
