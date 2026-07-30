import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/moodle_scaffold.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime(2026, 8, 15);
  DateTime? _selectedDay;
  bool _upcomingOnly = true;

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<CalendarEvent> get _visibleEvents {
    final now = _dateOnly(DateTime.now());
    var events = List<CalendarEvent>.from(dummyCalendarEvents);

    if (_upcomingOnly) {
      events = events.where((event) {
        return !_dateOnly(event.date).isBefore(now);
      }).toList();
    }

    return events..sort((a, b) => a.date.compareTo(b.date));
  }

  List<CalendarEvent> _eventsForDay(DateTime day) {
    final target = _dateOnly(day);
    return _visibleEvents.where((event) {
      return _dateOnly(event.date) == target;
    }).toList();
  }

  Set<DateTime> get _markedDays {
    return _visibleEvents.map((e) => _dateOnly(e.date)).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final listEvents = _selectedDay == null
        ? _visibleEvents
        : _eventsForDay(_selectedDay!);

    return MoodleScaffold(
      appBar: const MoodleAppBar(title: 'Calendar'),
      backgroundColor: moodleBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = isWideScreen(context);

          final calendarSection = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Calendar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: moodlePurple,
                    ),
                  ),
                  const Spacer(),
                  FilterChip(
                    label: Text(_upcomingOnly ? 'Upcoming only' : 'All events'),
                    selected: _upcomingOnly,
                    onSelected: (value) => setState(() => _upcomingOnly = value),
                    selectedColor: moodlePurple.withValues(alpha: 0.15),
                    checkmarkColor: moodlePurple,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                color: moodleWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: moodleBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TableCalendar<CalendarEvent>(
                  firstDay: DateTime(2026, 1, 1),
                  lastDay: DateTime(2026, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _eventsForDay,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: moodleBlue.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: moodlePurple,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: moodlePurple,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = _dateOnly(selectedDay);
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (!_markedDays.contains(_dateOnly(day))) {
                        return null;
                      }
                      return Positioned(
                        bottom: 1,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: moodlePurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );

          final eventsSection = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _selectedDay == null
                        ? 'All events'
                        : 'Events on ${_formatDayHeading(_selectedDay!)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: moodlePurple,
                    ),
                  ),
                  if (_selectedDay != null) ...[
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() => _selectedDay = null),
                      child: const Text('Show all'),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              if (listEvents.isEmpty)
                const Text(
                  'No events for this selection.',
                  style: TextStyle(color: moodleTextMuted),
                )
              else
                ...listEvents.map(
                  (event) => Card(
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
                      title: Text(
                        event.title,
                        style: TextStyle(
                          fontWeight: event.title.contains('Coursework Deadline')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: moodleTextDark,
                        ),
                      ),
                      subtitle: Text(
                        '${event.typeLabel} · ${_formatDayHeading(_dateOnly(event.date))}',
                      ),
                      trailing: Text(
                        _formatTime(event.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: moodleTextMuted,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: calendarSection),
                    const SizedBox(width: 16),
                    Expanded(flex: 2, child: eventsSection),
                  ],
                )
              else ...[
                calendarSection,
                const SizedBox(height: 16),
                eventsSection,
              ],
            ],
          );
        },
      ),
    );
  }

  String _formatDayHeading(DateTime day) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${day.day} ${months[day.month - 1]} ${day.year}';
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
