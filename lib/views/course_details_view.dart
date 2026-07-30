import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/nav_drawer.dart';
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
    _loadCourse();
  }

  Future<void> _loadCourse() async {
    final course =
        await context.read<CourseProvider>().getCourseById(widget.courseId);
    if (mounted) {
      setState(() {
        _course = course;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoodleAppBar(
        title: _course?.code ?? 'Course details',
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _course == null
                ? const Center(
                    child: Text(
                      'Course not found.',
                      style: TextStyle(fontSize: 16, color: moodleTextMuted),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _course!.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: moodlePurple,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _course!.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: moodleTextDark,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ..._course!.sections.map(
                          (section) => _SectionCard(section: section),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class _SectionCard extends StatefulWidget {
  const _SectionCard({required this.section});

  final CourseSection section;

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool _expanded = true;

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
      child: ExpansionTile(
        initiallyExpanded: _expanded,
        onExpansionChanged: (value) => setState(() => _expanded = value),
        title: Text(
          widget.section.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        children: widget.section.items
            .map(
              (item) => ListTile(
                leading: const Icon(Icons.article_outlined, color: moodleBlue),
                title: Text(
                  item,
                  style: const TextStyle(fontSize: 14, color: moodleTextDark),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
