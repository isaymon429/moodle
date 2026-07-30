import 'package:flutter/foundation.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/services/auth_service.dart';
import 'package:moodle/services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider({
    CourseService? courseService,
    AuthService? authService,
  })  : _courseService = courseService ?? CourseService(),
        _authService = authService ?? AuthService();

  final CourseService _courseService;
  final AuthService _authService;

  List<Course> _courses = [];
  List<Assignment> _assignments = [];
  String _searchQuery = '';
  bool _isLoading = false;

  List<Course> get courses => List.unmodifiable(_filteredCourses());
  List<Assignment> get assignments => List.unmodifiable(_assignments);
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
              course.title.toLowerCase().contains(lowerQuery) ||
              course.code.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  Future<void> loadCourses() async {
    _isLoading = true;
    notifyListeners();

    _courses = await _courseService.getCourses();
    _assignments = await _authService.getAssignmentsForCurrentUser();

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
