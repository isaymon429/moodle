import 'package:flutter/foundation.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider({NotificationService? notificationService})
      : _notificationService = notificationService ?? NotificationService();

  final NotificationService _notificationService;

  List<Announcement> _announcements = [];
  final Set<String> _readIds = {};
  bool _isLoading = false;

  List<Announcement> get announcements => List.unmodifiable(_announcements);
  bool get isLoading => _isLoading;

  bool isRead(String id) => _readIds.contains(id);

  int get unreadCount =>
      _announcements.where((a) => !_readIds.contains(a.id)).length;

  Future<void> loadAnnouncements() async {
    _isLoading = true;
    notifyListeners();

    _announcements = await _notificationService.getAnnouncements();

    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    _readIds.add(id);
    notifyListeners();
  }
}
