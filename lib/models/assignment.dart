enum AssignmentStatus {
  notSubmitted,
  submitted,
  graded,
}

class Assignment {
  const Assignment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.dueDate,
    required this.status,
    required this.description,
    this.grade,
  });

  final String id;
  final String courseId;
  final String title;
  final DateTime dueDate;
  final AssignmentStatus status;
  final String description;
  final String? grade;

  String get statusLabel {
    switch (status) {
      case AssignmentStatus.notSubmitted:
        return 'Not submitted';
      case AssignmentStatus.submitted:
        return 'Submitted';
      case AssignmentStatus.graded:
        return 'Graded';
    }
  }

  Assignment copyWith({
    AssignmentStatus? status,
    String? grade,
  }) {
    return Assignment(
      id: id,
      courseId: courseId,
      title: title,
      dueDate: dueDate,
      status: status ?? this.status,
      description: description,
      grade: grade ?? this.grade,
    );
  }
}
