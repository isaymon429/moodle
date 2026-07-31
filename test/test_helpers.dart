import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/auth_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:provider/provider.dart';

import 'mock_auth_provider.dart';

/// Wraps a test widget in MaterialApp.router with GoRouter and required Providers.
Widget createTestableWidget(Widget child) {
  final mockAuth = MockAuthProvider();
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(path: '/courses', builder: (context, state) => const Scaffold(body: Text('Courses'))),
      GoRoute(path: '/assessments', builder: (context, state) => const Scaffold(body: Text('Assessments'))),
      GoRoute(path: '/calendar', builder: (context, state) => const Scaffold(body: Text('Calendar'))),
      GoRoute(path: '/login', builder: (context, state) => const Scaffold(body: Text('Login'))),
    ],
  );

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>.value(value: mockAuth),
      ChangeNotifierProvider(create: (_) => CourseProvider()),
      ChangeNotifierProvider(create: (_) => AssignmentProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ],
    child: MaterialApp.router(
      routerConfig: router,
    ),
  );
}
