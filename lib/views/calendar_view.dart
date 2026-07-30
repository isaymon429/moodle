import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/providers/calendar_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarProvider>().loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendar = context.watch<CalendarProvider>();

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Calendar'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Calendar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: calendar.filter == 'all',
                      onSelected: () => calendar.setFilter('all'),
                    ),
                    _FilterChip(
                      label: 'Deadlines',
                      selected: calendar.filter == 'deadline',
                      onSelected: () => calendar.setFilter('deadline'),
                    ),
                    _FilterChip(
                      label: 'Lectures',
                      selected: calendar.filter == 'lecture',
                      onSelected: () => calendar.setFilter('lecture'),
                    ),
                    _FilterChip(
                      label: 'Workshops',
                      selected: calendar.filter == 'workshop',
                      onSelected: () => calendar.setFilter('workshop'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (calendar.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (calendar.events.isEmpty)
                const Text(
                  'No events match this filter.',
                  style: TextStyle(fontSize: 16, color: moodleTextMuted),
                )
              else
                ...calendar.events.map(
                  (event) => _CalendarEventTile(event: event),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        selectedColor: moodlePurple.withValues(alpha: 0.15),
        checkmarkColor: moodlePurple,
        labelStyle: TextStyle(
          color: selected ? moodlePurple : moodleTextDark,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _CalendarEventTile extends StatelessWidget {
  const _CalendarEventTile({required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: moodleGrayBg,
          foregroundColor: moodlePurple,
          child: Text(
            '${event.date.day}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        title: Text(
          event.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: moodleTextDark,
          ),
        ),
        subtitle: Text(
          '${event.typeLabel} · ${event.courseCode}',
          style: const TextStyle(color: moodleTextMuted),
        ),
      ),
    );
  }
}
