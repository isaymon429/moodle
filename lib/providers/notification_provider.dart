import 'package:flutter/foundation.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider({NotificationService? notificationService})
      : _notificationService = notificationService ?? NotificationService();

  final NotificationService _notificationService;

  List<Announcement> _announcements = [];
  bool _isLoading = false;

  List<Announcement> get announcements => List.unmodifiable(_announcements);
  bool get isLoading => _isLoading;

  int get unreadCount =>
      _announcements.where((announcement) => !announcement.isRead).length;

  Future<void> loadAnnouncements() async {
    _isLoading = true;
    notifyListeners();

    _announcements = await _notificationService.getAnnouncements();

    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    _announcements = _announcements
        .map(
          (announcement) => announcement.id == id
              ? Announcement(
                  id: announcement.id,
                  title: announcement.title,
                  message: announcement.message,
                  date: announcement.date,
                  isRead: true,
                )
              : announcement,
        )
        .toList();
    notifyListeners();
  }
}
