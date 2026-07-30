import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/assignment_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/providers/notification_provider.dart';
import 'package:moodle/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MoodleApp());
}

class MoodleApp extends StatefulWidget {
  const MoodleApp({Key? key}) : super(key: key);

  @override
  State<MoodleApp> createState() => _MoodleAppState();
}

class _MoodleAppState extends State<MoodleApp> {
  late final GoRouter _router = createRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => AssignmentProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp.router(
        title: 'Moodle',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: moodlePurple,
            primary: moodlePurple,
            secondary: moodleSecondary,
            surface: moodleSurface,
          ),
        ),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
