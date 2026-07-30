import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/routes.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/moodle_scaffold.dart';
import 'package:provider/provider.dart';

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  final String courseId;

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  Course? _course;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    await context.read<NotificationProvider>().loadAnnouncements();
    if (!mounted) return;
    await context.read<AssignmentProvider>().loadAssignments();
    if (!mounted) return;
    final course =
        await context.read<CourseProvider>().getCourseById(widget.courseId);
    if (mounted) {
      setState(() {
        _course = course;
        _isLoading = false;
      });
    }
  }

  List<Announcement> _courseAnnouncements(List<Announcement> all) {
    return all.where((a) => a.courseId == widget.courseId).toList();
  }

  void _openCourseAssessments() {
    context.go(
      '${AppRoutes.assessments}?courseId=${widget.courseId}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final announcements = context.watch<NotificationProvider>().announcements;
    final assignments =
        context.watch<AssignmentProvider>().forCourse(widget.courseId);

    return MoodleScaffold(
      showNavigation: false,
      backgroundColor: moodleBg,
      appBar: MoodleAppBar(
        title: _course?.code ?? 'Course',
        showBackButton: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _course == null
              ? const Center(
                  child: Text(
                    'Course not found.',
                    style: TextStyle(color: moodleTextMuted),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      _course!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: moodlePurple,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_course!.instructor} · ${_course!.term}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: moodleTextMuted,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Announcements'),
                    Card(
                      color: moodleWhite,
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 24),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: moodleBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _courseAnnouncements(announcements).isEmpty
                          ? const ListTile(
                              title: Text(
                                'No announcements for this module yet.',
                              ),
                            )
                          : Column(
                              children: _courseAnnouncements(announcements)
                                  .map(
                                (announcement) => ListTile(
                                  leading: const Icon(
                                    Icons.campaign_outlined,
                                    color: moodleBlue,
                                  ),
                                  title: Text(announcement.title),
                                  subtitle: Text(
                                    announcement.body,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ).toList(),
                            ),
                    ),
                    const _SectionHeader(title: 'Topics'),
                    ..._course!.topics.map((topic) {
                      return Card(
                        color: moodleWhite,
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: moodleBorder),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            topic.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: moodlePurple,
                            ),
                          ),
                          children: topic.resources
                              .map(
                                (resource) => ListTile(
                                  leading: const Icon(
                                    Icons.insert_drive_file_outlined,
                                    color: moodleBlue,
                                  ),
                                  title: Text(resource),
                                  dense: true,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const _SectionHeader(title: 'Assessments'),
                        const Spacer(),
                        TextButton(
                          onPressed: assignments.isEmpty
                              ? null
                              : _openCourseAssessments,
                          child: const Text('View all'),
                        ),
                      ],
                    ),
                    Card(
                      color: moodleWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: moodleBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: assignments.isEmpty
                          ? const ListTile(
                              title: Text(
                                'No assessments listed for this module.',
                              ),
                            )
                          : Column(
                              children: assignments.map((assignment) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.assignment_outlined,
                                    color: moodlePurple,
                                  ),
                                  title: Text(assignment.title),
                                  subtitle: Text(
                                    'Due ${_formatDate(assignment.dueDate)} · ${assignment.statusLabel}',
                                  ),
                                  trailing: const Icon(
                                    Icons.chevron_right,
                                    color: moodleTextMuted,
                                  ),
                                  onTap: _openCourseAssessments,
                                );
                              }).toList(),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: moodlePurple,
        ),
      ),
    );
  }
}
