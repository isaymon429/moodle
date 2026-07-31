import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/views/dashboard_view.dart';
import 'package:moodle/widgets/course_card.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('DashboardView renders course cards and upcoming deadlines section',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const DashboardView()));
    await tester.pumpAndSettle();

    // Verify 'My courses' header and CourseCard widgets are rendered
    expect(find.text('My courses'), findsOneWidget);
    expect(find.byType(CourseCard), findsWidgets);

    // Verify 'Upcoming deadlines' section is rendered
    expect(find.text('Upcoming deadlines'), findsOneWidget);
  });
}
