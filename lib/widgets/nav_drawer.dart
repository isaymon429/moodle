import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/auth_provider.dart';
import 'package:moodle/routes.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  void _navigate(BuildContext context, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? AppRoutes.dashboard;
    Navigator.pop(context);
    if (currentRoute != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? AppRoutes.dashboard;
    final user = context.watch<AuthProvider>().user;

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
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: moodleWhite,
                    child: Icon(Icons.person, size: 30, color: moodlePurple),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      color: moodleWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.speed_outlined,
              label: 'Dashboard',
              selected: currentRoute == AppRoutes.dashboard,
              onTap: () => _navigate(context, AppRoutes.dashboard),
            ),
            _DrawerItem(
              icon: Icons.calendar_month_outlined,
              label: 'Calendar',
              selected: currentRoute == AppRoutes.calendar,
              onTap: () => _navigate(context, AppRoutes.calendar),
            ),
            _DrawerItem(
              icon: Icons.school_outlined,
              label: 'My courses',
              selected: currentRoute == AppRoutes.courses,
              onTap: () => _navigate(context, AppRoutes.courses),
            ),
            _DrawerItem(
              icon: Icons.assignment_outlined,
              label: 'Assessments',
              selected: currentRoute == AppRoutes.assessments,
              onTap: () => _navigate(context, AppRoutes.assessments),
            ),
            _DrawerItem(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              selected: currentRoute == AppRoutes.notifications,
              onTap: () => _navigate(context, AppRoutes.notifications),
            ),
            _DrawerItem(
              icon: Icons.person_outline,
              label: 'Profile',
              selected: currentRoute == AppRoutes.profile,
              onTap: () => _navigate(context, AppRoutes.profile),
            ),
            const Divider(color: Colors.white24),
            _DrawerItem(
              icon: Icons.logout,
              label: 'Log out',
              selected: false,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
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
