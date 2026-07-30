import 'package:flutter/foundation.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/services/announcement_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider({AnnouncementService? announcementService})
      : _announcementService = announcementService ?? AnnouncementService();

  final AnnouncementService _announcementService;

  List<Announcement> _announcements = [];
  final Set<String> _readIds = {};
  bool _isLoading = false;

  List<Announcement> get announcements => List.unmodifiable(_announcements);
  bool get isLoading => _isLoading;

  bool isRead(String id) => _readIds.contains(id);

  int get unreadCount =>
      _announcements.where((a) => !_readIds.contains(a.id)).length;

  List<Announcement> get recentAnnouncements {
    final sorted = List<Announcement>.from(_announcements)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  Future<void> loadAnnouncements() async {
    _isLoading = true;
    notifyListeners();

    _announcements = await _announcementService.getAnnouncements();

    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    _readIds.add(id);
    notifyListeners();
  }
}
