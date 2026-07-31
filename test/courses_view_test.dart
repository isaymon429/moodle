import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/views/courses_view.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('CoursesView search filters the list correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const CoursesView()));
    await tester.pumpAndSettle();

    // Verify initial course UXDI is listed
    expect(find.text('UXDI'), findsOneWidget);

    // Enter 'Database' into the search field
    await tester.enterText(find.byType(TextField), 'Database');
    await tester.pumpAndSettle();

    // Verify list is filtered: Database Management appears, UXDI is hidden
    expect(find.text('Database Management'), findsOneWidget);
    expect(find.text('UXDI'), findsNothing);
  });
}
