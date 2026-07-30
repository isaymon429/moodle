import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/moodle_scaffold.dart';
import 'package:provider/provider.dart';

class AssignmentDetailView extends StatefulWidget {
  const AssignmentDetailView({
    Key? key,
    required this.assignmentId,
  }) : super(key: key);

  final String assignmentId;

  @override
  State<AssignmentDetailView> createState() => _AssignmentDetailViewState();
}

class _AssignmentDetailViewState extends State<AssignmentDetailView> {
  final _commentController = TextEditingController();
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AssignmentProvider>().loadAssignments();
      final courseProvider = context.read<CourseProvider>();
      if (courseProvider.courses.isEmpty) {
        courseProvider.loadCourses();
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.name.isNotEmpty) {
      setState(() => _selectedFileName = result.files.single.name);
    }
  }

  void _submit(BuildContext context, Assignment assignment) {
    context.read<AssignmentProvider>().submitAssignment(assignment.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Assignment submitted successfully.')),
    );
    context.pop();
  }

  String? _courseCode(BuildContext context, String courseId) {
    try {
      return context
          .read<CourseProvider>()
          .courses
          .firstWhere((c) => c.id == courseId)
          .code;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final assignment =
        context.watch<AssignmentProvider>().getById(widget.assignmentId);

    if (assignment == null) {
      return MoodleScaffold(
        showNavigation: false,
        appBar: const MoodleAppBar(title: 'Assignment', showBackButton: true),
        body: const Center(
          child: Text(
            'Assignment not found.',
            style: TextStyle(color: moodleTextMuted),
          ),
        ),
      );
    }

    final canSubmit = assignment.status == AssignmentStatus.notSubmitted;

    return MoodleScaffold(
      showNavigation: false,
      backgroundColor: moodleBg,
      appBar: const MoodleAppBar(title: 'Assignment', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              assignment.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_courseCode(context, assignment.courseId) ?? 'Module'} · Due ${_formatDate(assignment.dueDate)}',
              style: const TextStyle(color: moodleTextMuted),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${assignment.statusLabel}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: moodleTextDark,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: moodleWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: moodleBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  assignment.description,
                  style: const TextStyle(fontSize: 15, color: moodleTextDark),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Submission',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              enabled: canSubmit,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Submission comment',
                hintText: 'Add a comment for your tutor...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: moodleWhite,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: canSubmit ? _pickFile : null,
              icon: const Icon(Icons.attach_file),
              label: Text(
                _selectedFileName ?? 'Attach file',
              ),
            ),
            if (_selectedFileName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Selected: $_selectedFileName',
                  style: const TextStyle(fontSize: 13, color: moodleTextMuted),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: canSubmit ? () => _submit(context, assignment) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: moodlePurple,
                foregroundColor: moodleWhite,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
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
