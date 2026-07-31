import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/views/assessments_view.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('AssessmentsView shows correct status chip colors',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const AssessmentsView()));
    await tester.pumpAndSettle();

    // Verify 'Not submitted' status chip text color
    final Text notSubmittedText =
        tester.widget(find.text('Not submitted').first);
    expect(notSubmittedText.style?.color, equals(moodleTextMuted));

    // Verify 'Submitted' status chip text color
    final Text submittedText = tester.widget(find.text('Submitted').first);
    expect(submittedText.style?.color, equals(moodleBlue));

    // Verify 'Graded' status chip text color
    final Text gradedText = tester.widget(find.text('Graded').first);
    expect(gradedText.style?.color, equals(const Color(0xFF2E7D32)));
  });
}
