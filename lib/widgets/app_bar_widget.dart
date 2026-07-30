import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/routes.dart';

class MoodleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoodleAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  final String title;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: moodleWhite,
      foregroundColor: moodleTextDark,
      elevation: 1,
      automaticallyImplyLeading: !showBackButton,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            )
          : null,
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
          onPressed: () => context.go(AppRoutes.notifications),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
