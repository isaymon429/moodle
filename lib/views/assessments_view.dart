import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/assignment_tile.dart';
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
      context.read<CourseProvider>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final assignments = context.watch<CourseProvider>().assignments;

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Assessments'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My assessments',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Track deadlines and submission status for your modules.',
                style: TextStyle(fontSize: 16, color: moodleTextMuted),
              ),
              const SizedBox(height: 24),
              if (assignments.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                ...assignments.map(
                  (assignment) => AssignmentTile(assignment: assignment),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
