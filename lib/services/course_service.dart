import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/course.dart';

class CourseService {
  Future<List<Course>> getCourses() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(dummyCourses);
  }

  Future<Course?> getCourseById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    try {
      return dummyCourses.firstWhere((course) => course.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Course>> searchCourses(String query) async {
    final courses = await getCourses();
    if (query.trim().isEmpty) {
      return courses;
    }
    final lowerQuery = query.toLowerCase();
    return courses
        .where(
          (course) =>
              course.title.toLowerCase().contains(lowerQuery) ||
              course.code.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
