import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/providers/course_provider.dart';

void main() {
  group('CourseProvider Unit Tests', () {
    test('CourseProvider returns the right filtered list for a search query', () async {
      final provider = CourseProvider();

      // Load sample courses into provider
      await provider.loadCourses();
      expect(provider.courses.length, equals(5));

      // Filter by search query 'UXDI'
      provider.setSearchQuery('UXDI');

      // Verify filtered list returns matching course only
      expect(provider.courses.length, equals(1));
      expect(provider.courses.first.code, equals('UXDI'));
      expect(
        provider.courses.first.name,
        equals('User Experience Design & Implementation'),
      );

      // Filter by search query with no match
      provider.setSearchQuery('NonExistentCourseQuery');
      expect(provider.courses, isEmpty);

      // Clear search query
      provider.setSearchQuery('');
      expect(provider.courses.length, equals(5));
    });
  });
}
