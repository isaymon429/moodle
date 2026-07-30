import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/announcement.dart';

class NotificationService {
  Future<List<Announcement>> getAnnouncements() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(dummyAnnouncements);
  }

  Future<int> getUnreadCount() async {
    final announcements = await getAnnouncements();
    return announcements.where((announcement) => !announcement.isRead).length;
  }

  Future<void> markAsRead(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}
