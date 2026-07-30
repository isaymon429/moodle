import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/assignment.dart';

class AssignmentService {
  Future<List<Assignment>> getAssignments() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(dummyAssignments);
  }

  Future<List<Assignment>> getAssignmentsForCourse(String courseId) async {
    final assignments = await getAssignments();
    return assignments.where((a) => a.courseId == courseId).toList();
  }
}
