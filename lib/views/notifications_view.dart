import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().loadAnnouncements();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationProvider>();

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Notifications'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: notifications.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: moodlePurple,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...notifications.announcements.map(
                    (announcement) => _AnnouncementTile(
                      announcement: announcement,
                      isRead: notifications.isRead(announcement.id),
                      onTap: () {
                        context
                            .read<NotificationProvider>()
                            .markAsRead(announcement.id);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _AnnouncementTile extends StatelessWidget {
  const _AnnouncementTile({
    required this.announcement,
    required this.isRead,
    required this.onTap,
  });

  final Announcement announcement;
  final bool isRead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isRead ? moodleWhite : moodleSurface,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      announcement.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isRead ? moodleTextMuted : moodlePurple,
                      ),
                    ),
                  ),
                  if (!isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: moodleBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                announcement.body,
                style: const TextStyle(fontSize: 14, color: moodleTextDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
