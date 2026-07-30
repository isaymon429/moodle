import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/models/announcement.dart';

class AnnouncementService {
  Future<List<Announcement>> getAnnouncements() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(dummyAnnouncements);
  }
}
