import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/routes.dart';
import 'package:provider/provider.dart';

/// Slide-in panel from the right (used as Scaffold endDrawer).
/// Shows recent announcements with unread indicators.
class NotificationPanel extends StatefulWidget {
  const NotificationPanel({Key? key}) : super(key: key);

  @override
  State<NotificationPanel> createState() => _NotificationPanelState();
}

class _NotificationPanelState extends State<NotificationPanel> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().loadAnnouncements();
    });
  }

  void _closePanel() {
    Navigator.of(context).pop();
  }

  void _seeAll() {
    _closePanel();
    context.go(AppRoutes.notifications);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 360,
      child: SafeArea(
        child: Consumer<NotificationProvider>(
          builder: (context, provider, _) {
            final items = provider.recentAnnouncements.take(5).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                  child: Row(
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: moodlePurple,
                        ),
                      ),
                      if (provider.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: moodleBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${provider.unreadCount} new',
                            style: const TextStyle(
                              color: moodleWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _closePanel,
                        tooltip: 'Close',
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : items.isEmpty
                          ? const Center(
                              child: Text(
                                'No notifications yet.',
                                style: TextStyle(color: moodleTextMuted),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: items.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1, indent: 16),
                              itemBuilder: (context, index) {
                                final announcement = items[index];
                                return _PanelItem(
                                  announcement: announcement,
                                  isRead: provider.isRead(announcement.id),
                                  onTap: () {
                                    provider.markAsRead(announcement.id);
                                  },
                                );
                              },
                            ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextButton(
                    onPressed: _seeAll,
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: moodleBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PanelItem extends StatelessWidget {
  const _PanelItem({
    required this.announcement,
    required this.isRead,
    required this.onTap,
  });

  final Announcement announcement;
  final bool isRead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Expanded(
            child: Text(
              announcement.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isRead ? moodleTextMuted : moodlePurple,
                fontSize: 14,
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
      subtitle: Text(
        announcement.body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 13, color: moodleTextDark),
      ),
    );
  }
}
