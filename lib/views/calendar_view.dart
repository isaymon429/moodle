import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/calendar_event.dart';

import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/nav_drawer.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  Map<DateTime, List<CalendarEvent>> _groupByDate(List<CalendarEvent> events) {
    final map = <DateTime, List<CalendarEvent>>{};
    for (final event in events) {
      final day = DateTime(event.date.year, event.date.month, event.date.day);
      map.putIfAbsent(day, () => []).add(event);
    }
    return map;
  }

  String _formatDayHeading(DateTime day) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${weekdays[day.weekday - 1]}, ${day.day} ${months[day.month - 1]} ${day.year}';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final sorted = List<CalendarEvent>.from(dummyCalendarEvents)
      ..sort((a, b) => a.date.compareTo(b.date));

    final upcoming = sorted.where((e) {
      final d = DateTime(e.date.year, e.date.month, e.date.day);
      return !d.isBefore(today);
    }).toList();

    final past = sorted.where((e) {
      final d = DateTime(e.date.year, e.date.month, e.date.day);
      return d.isBefore(today);
    }).toList();

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Calendar'),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          const Text(
            'Calendar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Upcoming',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 8),
          if (upcoming.isEmpty)
            const Text(
              'No upcoming events.',
              style: TextStyle(color: moodleTextMuted),
            )
          else
            ..._buildGroupedEvents(upcoming),
          const SizedBox(height: 24),
          const Text(
            'Past',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 8),
          if (past.isEmpty)
            const Text(
              'No past events.',
              style: TextStyle(color: moodleTextMuted),
            )
          else
            ..._buildGroupedEvents(past),
        ],
      ),
    );
  }

  List<Widget> _buildGroupedEvents(List<CalendarEvent> events) {
    final grouped = _groupByDate(events);
    final days = grouped.keys.toList()..sort();

    return days.expand((day) {
      final dayEvents = grouped[day]!
        ..sort((a, b) => a.date.compareTo(b.date));
      return [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(
            _formatDayHeading(day),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: moodleTextDark,
            ),
          ),
        ),
        ...dayEvents.map((event) => Card(
              color: moodleWhite,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: moodleBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(
                  _iconForType(event.type),
                  color: moodlePurple,
                ),
                title: Text(event.title),
                subtitle: Text(event.typeLabel),
                trailing: Text(
                  _formatTime(event.date),
                  style: const TextStyle(fontSize: 12, color: moodleTextMuted),
                ),
              ),
            )),
      ];
    }).toList();
  }

  IconData _iconForType(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.deadline:
        return Icons.event_busy_outlined;
      case CalendarEventType.exam:
        return Icons.quiz_outlined;
      case CalendarEventType.event:
        return Icons.event_outlined;
    }
  }

  String _formatTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
