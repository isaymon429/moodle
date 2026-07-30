import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/routes.dart';
import 'package:provider/provider.dart';
import 'package:moodle/providers/auth_provider.dart';

class MoodleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoodleAppBar({
    Key? key,
    required this.title,
    this.showDrawerMenu = true,
  }) : super(key: key);

  final String title;
  final bool showDrawerMenu;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final initials = context.watch<AuthProvider>().user.initials;

    return AppBar(
      backgroundColor: moodleWhite,
      foregroundColor: moodleTextDark,
      elevation: 1,
      titleSpacing: 0,
      automaticallyImplyLeading: showDrawerMenu,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: 32,
              height: 32,
              child: Image.asset(
                'images/moodle_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.school, color: moodlePurple, size: 28);
                },
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.notifications);
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profile);
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: moodleGrayBg,
            foregroundColor: moodlePurple,
            child: Text(
              initials,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
