import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/views/calendar_view.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('CalendarView marks the coursework deadline date',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const CalendarView()));
    await tester.pumpAndSettle();

    // Verify coursework deadline event is displayed and marked in the calendar view
    expect(find.text('Flutter Moodle Coursework Deadline'), findsOneWidget);
  });
}
