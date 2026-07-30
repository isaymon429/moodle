import 'package:flutter/foundation.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider({CourseService? courseService})
      : _courseService = courseService ?? CourseService();

  final CourseService _courseService;

  List<Course> _courses = [];
  String _searchQuery = '';
  bool _isLoading = false;

  List<Course> get courses => List.unmodifiable(_filteredCourses());
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  List<Course> _filteredCourses() {
    if (_searchQuery.trim().isEmpty) {
      return _courses;
    }
    final lowerQuery = _searchQuery.toLowerCase();
    return _courses
        .where(
          (course) =>
              course.name.toLowerCase().contains(lowerQuery) ||
              course.code.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  Future<void> loadCourses() async {
    _isLoading = true;
    notifyListeners();

    _courses = await _courseService.getCourses();

    _isLoading = false;
    notifyListeners();
  }

  Future<Course?> getCourseById(String id) {
    return _courseService.getCourseById(id);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
