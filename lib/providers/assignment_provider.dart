import 'package:flutter/foundation.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/services/assignment_service.dart';

class AssignmentProvider extends ChangeNotifier {
  AssignmentProvider({AssignmentService? assignmentService})
      : _assignmentService = assignmentService ?? AssignmentService();

  final AssignmentService _assignmentService;

  List<Assignment> _assignments = [];
  bool _isLoading = false;

  List<Assignment> get assignments => List.unmodifiable(_assignments);
  bool get isLoading => _isLoading;

  List<Assignment> get upcomingAssignments {
    final sorted = List<Assignment>.from(_assignments)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return sorted;
  }

  Future<void> loadAssignments() async {
    _isLoading = true;
    notifyListeners();

    _assignments = await _assignmentService.getAssignments();

    _isLoading = false;
    notifyListeners();
  }

  List<Assignment> forCourse(String courseId) {
    return _assignments.where((a) => a.courseId == courseId).toList();
  }

  List<Assignment> filtered({String? courseId}) {
    if (courseId == null) {
      return assignments;
    }
    return forCourse(courseId);
  }

  Assignment? getById(String id) {
    try {
      return _assignments.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  void submitAssignment(String id) {
    _assignments = _assignments
        .map(
          (assignment) => assignment.id == id
              ? assignment.copyWith(status: AssignmentStatus.submitted)
              : assignment,
        )
        .toList();
    notifyListeners();
  }
}
