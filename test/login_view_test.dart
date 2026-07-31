import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/views/login_view.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('LoginView shows email/password fields and Google button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(createTestableWidget(const LoginView()));
    await tester.pumpAndSettle();

    // Verify email and password TextFields are rendered
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Verify 'Continue with Google' button is rendered
    expect(find.text('Continue with Google'), findsOneWidget);
  });
}
