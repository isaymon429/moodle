enum CalendarEventType {
  deadline,
  lecture,
  workshop,
  exam,
}

class CalendarEvent {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
    required this.courseCode,
  });

  final String id;
  final String title;
  final DateTime date;
  final CalendarEventType type;
  final String courseCode;

  String get typeLabel {
    switch (type) {
      case CalendarEventType.deadline:
        return 'Deadline';
      case CalendarEventType.lecture:
        return 'Lecture';
      case CalendarEventType.workshop:
        return 'Workshop';
      case CalendarEventType.exam:
        return 'Exam';
    }
  }
}
