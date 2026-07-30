import 'package:flutter/foundation.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/calendar_event.dart';

/// Loads calendar events from dummy data for now.
/// Swap in a [CalendarService] when moving to live data.
class CalendarProvider extends ChangeNotifier {
  List<CalendarEvent> _events = [];
  bool _isLoading = false;
  String _filter = 'all';

  List<CalendarEvent> get events {
    final sorted = List<CalendarEvent>.from(_events)
      ..sort((a, b) => a.date.compareTo(b.date));
    if (_filter == 'all') {
      return List.unmodifiable(sorted);
    }
    return List.unmodifiable(
      sorted.where((event) => event.type.name == _filter),
    );
  }

  bool get isLoading => _isLoading;
  String get filter => _filter;

  Future<void> loadEvents() async {
    _isLoading = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 100));
    _events = List.unmodifiable(dummyCalendarEvents);

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }
}
