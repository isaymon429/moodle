import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/course_card.dart';
import 'package:moodle/widgets/nav_drawer.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const _pagePadding = EdgeInsets.all(16);

  List<Assignment> get _upcomingAssignments {
    final sorted = List<Assignment>.from(dummyAssignments)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return sorted.take(3).toList();
  }

  List<Announcement> get _recentAnnouncements {
    final sorted = List<Announcement>.from(dummyAnnouncements)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = dummyUserProfile.fullName.split(' ').first;

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Dashboard'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SingleChildScrollView(
          padding: _pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, $firstName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dummyUserProfile.programme,
                style: const TextStyle(fontSize: 14, color: moodleTextMuted),
              ),
              const SizedBox(height: 24),
              const _SectionTitle(title: 'My courses'),
              const SizedBox(height: 12),
              SizedBox(
                height: 118,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyCourses.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 260,
                      child: CourseCard(
                        course: dummyCourses[index],
                        compact: true,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const _SectionTitle(title: 'Upcoming deadlines'),
              const SizedBox(height: 12),
              Card(
                color: moodleWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: moodleBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: _pagePadding,
                  child: Column(
                    children: _upcomingAssignments.map((assignment) {
                      return _DeadlineRow(assignment: assignment);
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const _SectionTitle(title: 'Recent announcements'),
              const SizedBox(height: 12),
              Card(
                color: moodleWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: moodleBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: _pagePadding,
                  child: Column(
                    children: _recentAnnouncements.map((announcement) {
                      return _AnnouncementRow(announcement: announcement);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: moodlePurple,
      ),
    );
  }
}

class _DeadlineRow extends StatelessWidget {
  const _DeadlineRow({required this.assignment});

  final Assignment assignment;

  String? get _courseCode {
    try {
      return dummyCourses
          .firstWhere((course) => course.id == assignment.courseId)
          .code;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: moodleGrayBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.event, size: 20, color: moodlePurple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: moodleTextDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_courseCode ?? 'Module'} · Due ${_formatDate(assignment.dueDate)}',
                  style: const TextStyle(fontSize: 13, color: moodleTextMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class _AnnouncementRow extends StatelessWidget {
  const _AnnouncementRow({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            announcement.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: moodleTextMuted),
          ),
        ],
      ),
    );
  }
}
