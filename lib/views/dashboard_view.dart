import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/routes.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/course_card.dart';
import 'package:moodle/widgets/moodle_scaffold.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  static const _pagePadding = EdgeInsets.all(16);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
      context.read<AssignmentProvider>().loadAssignments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseProvider>().courses;
    final assignments = context.watch<AssignmentProvider>().upcomingAssignments;
    final announcements = context.watch<NotificationProvider>().recentAnnouncements;
    final firstName = dummyUserProfile.fullName.split(' ').first;

    return MoodleScaffold(
      appBar: const MoodleAppBar(title: 'Dashboard'),
      body: Container(
        color: moodleBg,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            final columns = gridColumnCount(screenWidth);
            final wide = isWideScreen(context);

            return SingleChildScrollView(
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
                  _SectionHeader(
                    title: 'My courses',
                    onViewAll: () => context.go(AppRoutes.courses),
                  ),
                  const SizedBox(height: 12),
                  if (wide)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.4,
                      ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return CourseCard(
                          course: courses[index],
                          compact: true,
                        );
                      },
                    )
                  else
                    SizedBox(
                      height: 118,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 260,
                            child: CourseCard(
                              course: courses[index],
                              compact: true,
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 24),
                  if (wide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _DeadlinesSection(
                            assignments: assignments.take(3).toList(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _AnnouncementsSection(
                            announcements: announcements.take(2).toList(),
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _SectionHeader(
                      title: 'Upcoming deadlines',
                      onViewAll: () => context.go(AppRoutes.assessments),
                    ),
                    const SizedBox(height: 12),
                    _DeadlinesCard(
                      assignments: assignments.take(3).toList(),
                    ),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      title: 'Recent announcements',
                      onViewAll: () => context.go(AppRoutes.notifications),
                    ),
                    const SizedBox(height: 12),
                    _AnnouncementsCard(
                      announcements: announcements.take(2).toList(),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.onViewAll,
  });

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAll,
          child: const Text(
            'View all',
            style: TextStyle(color: moodleBlue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _DeadlinesSection extends StatelessWidget {
  const _DeadlinesSection({required this.assignments});

  final List<Assignment> assignments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Upcoming deadlines',
          onViewAll: () => context.go(AppRoutes.assessments),
        ),
        const SizedBox(height: 12),
        _DeadlinesCard(assignments: assignments),
      ],
    );
  }
}

class _AnnouncementsSection extends StatelessWidget {
  const _AnnouncementsSection({required this.announcements});

  final List<Announcement> announcements;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Recent announcements',
          onViewAll: () => context.go(AppRoutes.notifications),
        ),
        const SizedBox(height: 12),
        _AnnouncementsCard(announcements: announcements),
      ],
    );
  }
}

class _DeadlinesCard extends StatelessWidget {
  const _DeadlinesCard({required this.assignments});

  final List<Assignment> assignments;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: assignments.map((assignment) {
            return _DeadlineRow(assignment: assignment);
          }).toList(),
        ),
      ),
    );
  }
}

class _AnnouncementsCard extends StatelessWidget {
  const _AnnouncementsCard({required this.announcements});

  final List<Announcement> announcements;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: announcements.map((announcement) {
            return _AnnouncementRow(announcement: announcement);
          }).toList(),
        ),
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
