import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/widgets/course_card.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: moodleBg,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          const Text(
            'My courses',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 16),
          ...dummyCourses.map(
            (course) => CourseCard(
              course: course,
              onTap: () {
                debugPrint('Tapped course: ${course.code} (${course.id})');
              },
            ),
          ),
        ],
      ),
    );
  }
}
