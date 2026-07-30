import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/routes.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
    this.compact = false,
    this.onTap,
  }) : super(key: key);

  final Course course;
  final bool compact;
  final VoidCallback? onTap;

  Color get _accentColor {
    final hex = course.colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  void _handleTap(BuildContext context) {
    if (onTap != null) {
      onTap!();
      return;
    }
    Navigator.pushNamed(
      context,
      AppRoutes.courseDetails,
      arguments: course,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = compact ? 12.0 : 20.0;

    return Card(
      color: moodleWhite,
      elevation: 0,
      margin: compact ? EdgeInsets.zero : const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _handleTap(context),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: compact ? 48 : 56,
                decoration: BoxDecoration(
                  color: _accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      course.code,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: moodleTextMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.name,
                      style: TextStyle(
                        fontSize: compact ? 14 : 16,
                        fontWeight: FontWeight.bold,
                        color: moodlePurple,
                      ),
                      maxLines: compact ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${course.instructor} · ${course.term}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: moodleTextMuted,
                      ),
                      maxLines: compact ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!compact)
                const Icon(Icons.chevron_right, color: moodleTextMuted),
            ],
          ),
        ),
      ),
    );
  }
}
