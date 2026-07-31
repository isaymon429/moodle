import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/routes.dart';
import 'package:moodle/widgets/moodle_scaffold.dart';
import 'package:provider/provider.dart';

class GlobalSearchView extends StatefulWidget {
  const GlobalSearchView({Key? key}) : super(key: key);

  @override
  State<GlobalSearchView> createState() => _GlobalSearchViewState();
}

class _GlobalSearchViewState extends State<GlobalSearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
      context.read<AssignmentProvider>().loadAssignments();
      context.read<NotificationProvider>().loadAnnouncements();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final assignmentProvider = context.watch<AssignmentProvider>();
    final notificationProvider = context.watch<NotificationProvider>();

    final cleanQuery = _query.trim().toLowerCase();

    // Query CourseProvider, AssignmentProvider, NotificationProvider simultaneously
    final matchingCourses = cleanQuery.isEmpty
        ? <Course>[]
        : courseProvider.courses.where((c) {
            return c.name.toLowerCase().contains(cleanQuery) ||
                c.code.toLowerCase().contains(cleanQuery) ||
                c.instructor.toLowerCase().contains(cleanQuery);
          }).toList();

    final matchingAssignments = cleanQuery.isEmpty
        ? <Assignment>[]
        : assignmentProvider.assignments.where((a) {
            return a.title.toLowerCase().contains(cleanQuery) ||
                a.description.toLowerCase().contains(cleanQuery);
          }).toList();

    final matchingAnnouncements = cleanQuery.isEmpty
        ? <Announcement>[]
        : notificationProvider.announcements.where((ann) {
            return ann.title.toLowerCase().contains(cleanQuery) ||
                ann.body.toLowerCase().contains(cleanQuery);
          }).toList();

    final totalResults = matchingCourses.length +
        matchingAssignments.length +
        matchingAnnouncements.length;

    return MoodleScaffold(
      showNavigation: false,
      appBar: AppBar(
        backgroundColor: moodleWhite,
        foregroundColor: moodleTextDark,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search courses, assessments, announcements...',
            border: InputBorder.none,
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
          ),
          onChanged: (val) {
            setState(() => _query = val);
          },
        ),
      ),
      body: _buildBody(
        cleanQuery: cleanQuery,
        totalResults: totalResults,
        courses: matchingCourses,
        assignments: matchingAssignments,
        announcements: matchingAnnouncements,
      ),
    );
  }

  Widget _buildBody({
    required String cleanQuery,
    required int totalResults,
    required List<Course> courses,
    required List<Assignment> assignments,
    required List<Announcement> announcements,
  }) {
    if (cleanQuery.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Type to search across courses, assessments & announcements',
              textAlign: TextAlign.center,
              style: TextStyle(color: moodleTextMuted, fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (totalResults == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No results found for "$_query"',
              style: const TextStyle(
                color: moodleTextDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try checking for spelling errors or searching another keyword.',
              textAlign: TextAlign.center,
              style: TextStyle(color: moodleTextMuted, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (courses.isNotEmpty) ...[
          _buildSectionHeader('Courses', Icons.school, moodlePurple),
          ...courses.map((c) => _buildCourseTile(c)),
          const SizedBox(height: 16),
        ],
        if (assignments.isNotEmpty) ...[
          _buildSectionHeader('Assessments', Icons.assignment, moodleSecondary),
          ...assignments.map((a) => _buildAssignmentTile(a)),
          const SizedBox(height: 16),
        ],
        if (announcements.isNotEmpty) ...[
          _buildSectionHeader(
            'Announcements',
            Icons.campaign,
            moodleBlue,
          ),
          ...announcements.map((ann) => _buildAnnouncementTile(ann)),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseTile(Course course) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: moodlePurple.withValues(alpha: 0.1),
          child: const Icon(Icons.book_outlined, color: moodlePurple),
        ),
        title: Text(
          '${course.code}: ${course.name}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Instructor: ${course.instructor} • ${course.term}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push(AppRoutes.courseDetails(course.id));
        },
      ),
    );
  }

  Widget _buildAssignmentTile(Assignment assignment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: moodleSecondary.withValues(alpha: 0.1),
          child: const Icon(Icons.assignment_outlined, color: moodleSecondary),
        ),
        title: Text(
          assignment.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Status: ${assignment.statusLabel} • Due: ${assignment.dueDate.day}/${assignment.dueDate.month}/${assignment.dueDate.year}',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push(AppRoutes.assignmentDetail(assignment.id));
        },
      ),
    );
  }

  Widget _buildAnnouncementTile(Announcement announcement) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: moodleBlue.withValues(alpha: 0.1),
          child: const Icon(Icons.campaign_outlined, color: moodleBlue),
        ),
        title: Text(
          announcement.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          announcement.body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if (announcement.courseId != null) {
            context.push(AppRoutes.courseDetails(announcement.courseId!));
          } else {
            context.push(AppRoutes.notifications);
          }
        },
      ),
    );
  }
}
