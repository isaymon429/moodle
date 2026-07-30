import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class MoodleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoodleAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: moodleWhite,
      foregroundColor: moodleTextDark,
      elevation: 1,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
