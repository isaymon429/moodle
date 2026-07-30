import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  void _closeDrawer(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Drawer(
      backgroundColor: moodlePurple,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: moodleDarkPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: moodleWhite,
                    child: Icon(Icons.person, size: 30, color: moodlePurple),
                  ),
                  SizedBox(height: 10),
                  Text(
                    dummyUserProfile.fullName,
                    style: TextStyle(
                      color: moodleWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    dummyUserProfile.email,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.dashboard_outlined,
              label: 'Dashboard',
              selected: currentRoute == '/',
              onTap: () => _closeDrawer(context),
            ),
            _DrawerItem(
              icon: Icons.school_outlined,
              label: 'Courses',
              selected: currentRoute == '/courses',
              onTap: () => _closeDrawer(context),
            ),
            _DrawerItem(
              icon: Icons.assignment_outlined,
              label: 'Assessments',
              selected: currentRoute == '/assessments',
              onTap: () => _closeDrawer(context),
            ),
            _DrawerItem(
              icon: Icons.calendar_month_outlined,
              label: 'Calendar',
              selected: currentRoute == '/calendar',
              onTap: () => _closeDrawer(context),
            ),
            _DrawerItem(
              icon: Icons.person_outline,
              label: 'Profile',
              selected: currentRoute == '/profile',
              onTap: () => _closeDrawer(context),
            ),
            _DrawerItem(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              selected: currentRoute == '/notifications',
              onTap: () => _closeDrawer(context),
            ),
            const Divider(color: Colors.white24),
            _DrawerItem(
              icon: Icons.logout,
              label: 'Logout',
              selected: false,
              onTap: () => _closeDrawer(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: moodleWhite),
      title: Text(
        label,
        style: const TextStyle(color: moodleWhite, fontSize: 16),
      ),
      selected: selected,
      selectedTileColor: Colors.white24,
      onTap: onTap,
    );
  }
}
