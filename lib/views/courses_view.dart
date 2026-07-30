import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/course_card.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Courses'),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: courseProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'My courses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: moodlePurple,
                  ),
                ),
                const SizedBox(height: 16),
                ...courseProvider.courses.map(
                  (course) => CourseCard(course: course),
                ),
              ],
            ),
    );
  }
}
