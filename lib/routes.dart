import 'package:flutter/material.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/views/assessments_view.dart';
import 'package:moodle/views/calendar_view.dart';
import 'package:moodle/views/course_details_view.dart';
import 'package:moodle/views/courses_view.dart';
import 'package:moodle/views/dashboard_view.dart';
import 'package:moodle/views/login_view.dart';
import 'package:moodle/views/notifications_view.dart';
import 'package:moodle/views/profile_view.dart';

class AppRoutes {
  static const dashboard = '/';
  static const courses = '/courses';
  static const courseDetails = '/courses/details';
  static const profile = '/profile';
  static const assessments = '/assessments';
  static const calendar = '/calendar';
  static const login = '/login';
  static const notifications = '/notifications';

  static Map<String, WidgetBuilder> get routes => {
        dashboard: (context) => const DashboardView(),
        courses: (context) => const CoursesView(),
        profile: (context) => const ProfileView(),
        assessments: (context) => const AssessmentsView(),
        calendar: (context) => const CalendarView(),
        login: (context) => const LoginView(),
        notifications: (context) => const NotificationsView(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == courseDetails) {
      final course = settings.arguments as Course?;
      if (course == null) {
        return MaterialPageRoute(
          builder: (context) => const CoursesView(),
        );
      }
      return MaterialPageRoute(
        builder: (context) => CourseDetailsView(course: course),
        settings: settings,
      );
    }
    return null;
  }
}
