import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = dummyUserProfile;
    final courses = context.watch<CourseProvider>().courses;

    return Scaffold(
      appBar: const MoodleAppBar(title: 'Profile'),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: moodleGrayBg,
              child: Icon(Icons.person, size: 52, color: moodlePurple),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              user.fullName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: moodleWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: moodleBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge_outlined, color: moodlePurple),
                  title: const Text('UP number'),
                  subtitle: Text(user.upNumber),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school_outlined, color: moodlePurple),
                  title: const Text('Programme'),
                  subtitle: Text(user.programme),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email_outlined, color: moodlePurple),
                  title: const Text('Email'),
                  subtitle: Text(user.email),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Enrolled modules',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: moodlePurple,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: moodleWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: moodleBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: courses.map((course) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: moodleGrayBg,
                        foregroundColor: moodlePurple,
                        child: Text(
                          course.code,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(course.name),
                      subtitle: Text('${course.instructor} · ${course.term}'),
                    ),
                    if (course != courses.last) const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
