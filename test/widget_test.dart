import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:moodle/main.dart';

void main() {
  testWidgets('App shows login screen on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const MoodleApp());
    await tester.pumpAndSettle();

    expect(find.text('Log in to Moodle'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });
}
