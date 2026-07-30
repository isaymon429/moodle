import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/routes.dart';

/// Mobile slide-out navigation drawer.
class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: moodlePurple,
      child: const NavDrawerContent(),
    );
  }
}

/// Permanent side rail shown on wide screens (inside [MoodleScaffold]).
class NavSidebar extends StatelessWidget {
  const NavSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: moodlePurple,
      child: NavDrawerContent(isPermanent: true),
    );
  }
}

/// Shared nav menu content for drawer and permanent sidebar.
class NavDrawerContent extends StatelessWidget {
  const NavDrawerContent({Key? key, this.isPermanent = false}) : super(key: key);

  final bool isPermanent;

  void _goTo(BuildContext context, String path) {
    if (!isPermanent) {
      Navigator.pop(context);
    }
    context.go(path);
  }

  bool _isSelected(String currentPath, String route) {
    if (route == AppRoutes.courses) {
      return currentPath == AppRoutes.courses ||
          currentPath.startsWith('${AppRoutes.courses}/');
    }
    return currentPath == route;
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return SafeArea(
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
                  dummyUserProfile.fullName,
                  style: const TextStyle(
                    color: moodleWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  dummyUserProfile.email,
                  style: const TextStyle(
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
            selected: _isSelected(currentPath, AppRoutes.dashboard),
            onTap: () => _goTo(context, AppRoutes.dashboard),
          ),
          _DrawerItem(
            icon: Icons.school_outlined,
            label: 'Courses',
            selected: _isSelected(currentPath, AppRoutes.courses),
            onTap: () => _goTo(context, AppRoutes.courses),
          ),
          _DrawerItem(
            icon: Icons.assignment_outlined,
            label: 'Assessments',
            selected: _isSelected(currentPath, AppRoutes.assessments),
            onTap: () => _goTo(context, AppRoutes.assessments),
          ),
          _DrawerItem(
            icon: Icons.calendar_month_outlined,
            label: 'Calendar',
            selected: _isSelected(currentPath, AppRoutes.calendar),
            onTap: () => _goTo(context, AppRoutes.calendar),
          ),
          _DrawerItem(
            icon: Icons.person_outline,
            label: 'Profile',
            selected: _isSelected(currentPath, AppRoutes.profile),
            onTap: () => _goTo(context, AppRoutes.profile),
          ),
          _DrawerItem(
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            selected: _isSelected(currentPath, AppRoutes.notifications),
            onTap: () => _goTo(context, AppRoutes.notifications),
          ),
          const Divider(color: Colors.white24),
          _DrawerItem(
            icon: Icons.logout,
            label: 'Logout',
            selected: false,
            onTap: () => _goTo(context, AppRoutes.login),
          ),
        ],
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
