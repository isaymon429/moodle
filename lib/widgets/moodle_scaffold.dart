import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/notification_panel.dart';
import 'package:provider/provider.dart';

/// Main page layout: slide-out drawer on narrow screens, permanent side
/// rail on wide screens, plus a notification endDrawer on all sizes.
class MoodleScaffold extends StatefulWidget {
  const MoodleScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.showNavigation = true,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  /// When false (e.g. course detail), only the notification panel is shown.
  final bool showNavigation;

  @override
  State<MoodleScaffold> createState() => _MoodleScaffoldState();
}

class _MoodleScaffoldState extends State<MoodleScaffold> {
  static const _sidebarWidth = 280.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().loadAnnouncements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > desktopBreakpoint;

        if (wide && widget.showNavigation) {
          return Scaffold(
            appBar: widget.appBar,
            backgroundColor: widget.backgroundColor,
            endDrawer: const NotificationPanel(),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  width: _sidebarWidth,
                  child: NavSidebar(),
                ),
                Expanded(child: widget.body),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: widget.appBar,
          drawer: widget.showNavigation ? const NavDrawer() : null,
          backgroundColor: widget.backgroundColor,
          endDrawer: const NotificationPanel(),
          body: widget.body,
        );
      },
    );
  }
}
