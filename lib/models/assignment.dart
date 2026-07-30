enum AssignmentStatus {
  notStarted,
  inProgress,
  submitted,
  overdue,
}

class Assignment {
  const Assignment({
    required this.id,
    required this.courseId,
    required this.courseCode,
    required this.title,
    required this.dueDate,
    required this.status,
    required this.description,
  });

  final String id;
  final String courseId;
  final String courseCode;
  final String title;
  final DateTime dueDate;
  final AssignmentStatus status;
  final String description;

  String get statusLabel {
    switch (status) {
      case AssignmentStatus.notStarted:
        return 'Not started';
      case AssignmentStatus.inProgress:
        return 'In progress';
      case AssignmentStatus.submitted:
        return 'Submitted';
      case AssignmentStatus.overdue:
        return 'Overdue';
    }
  }
}
