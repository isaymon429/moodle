enum CalendarEventType {
  deadline,
  exam,
  event,
}

class CalendarEvent {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
  });

  final String id;
  final String title;
  final DateTime date;
  final CalendarEventType type;

  String get typeLabel {
    switch (type) {
      case CalendarEventType.deadline:
        return 'Deadline';
      case CalendarEventType.exam:
        return 'Exam';
      case CalendarEventType.event:
        return 'Event';
    }
  }
}
