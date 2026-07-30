import 'package:go_router/go_router.dart';
import 'package:moodle/views/assessments_view.dart';
import 'package:moodle/views/assignment_detail_view.dart';
import 'package:moodle/views/calendar_view.dart';
import 'package:moodle/views/course_details_view.dart';
import 'package:moodle/views/courses_view.dart';
import 'package:moodle/views/dashboard_view.dart';
import 'package:moodle/views/login_view.dart';
import 'package:moodle/views/notifications_view.dart';
import 'package:moodle/views/profile_view.dart';

/// Named route paths used across the app (drawer, cards, buttons).
class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const courses = '/courses';
  static const assessments = '/assessments';
  static const calendar = '/calendar';
  static const profile = '/profile';
  static const notifications = '/notifications';

  static String courseDetails(String id) => '/courses/$id';
  static String assignmentDetail(String id) => '/assignments/$id';
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: AppRoutes.courses,
        builder: (context, state) => const CoursesView(),
      ),
      GoRoute(
        path: '/courses/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CourseDetailsView(courseId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.assessments,
        builder: (context, state) {
          final courseId = state.uri.queryParameters['courseId'];
          return AssessmentsView(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/assignments/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AssignmentDetailView(assignmentId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.calendar,
        builder: (context, state) => const CalendarView(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsView(),
      ),
    ],
  );
}
