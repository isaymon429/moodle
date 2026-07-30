import 'package:flutter/foundation.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider({CourseService? courseService})
      : _courseService = courseService ?? CourseService();

  final CourseService _courseService;

  List<Course> _courses = [];
  String _searchQuery = '';
  String? _termFilter;
  bool _favouritesOnly = false;
  bool _isLoading = false;

  List<Course> get courses => List.unmodifiable(_filteredCourses());
  String get searchQuery => _searchQuery;
  String? get termFilter => _termFilter;
  bool get favouritesOnly => _favouritesOnly;
  bool get isLoading => _isLoading;

  List<String> get availableTerms {
    return _courses.map((c) => c.term).toSet().toList()..sort();
  }

  List<Course> _filteredCourses() {
    var result = List<Course>.from(_courses);

    if (_searchQuery.trim().isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      result = result
          .where(
            (course) =>
                course.name.toLowerCase().contains(lowerQuery) ||
                course.code.toLowerCase().contains(lowerQuery),
          )
          .toList();
    }

    if (_termFilter != null) {
      result = result.where((course) => course.term == _termFilter).toList();
    }

    if (_favouritesOnly) {
      result = result.where((course) => course.isFavourite).toList();
    }

    return result;
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

  void setTermFilter(String? term) {
    _termFilter = term;
    notifyListeners();
  }

  void setFavouritesOnly(bool value) {
    _favouritesOnly = value;
    notifyListeners();
  }
}
