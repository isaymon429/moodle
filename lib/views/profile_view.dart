import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/auth_provider.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/moodle_scaffold.dart';
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
    final firebaseUser = context.watch<AuthProvider>().user;
    final courses = context.watch<CourseProvider>().courses;

    final displayName = firebaseUser?.displayName?.trim();
    final email = firebaseUser?.email?.trim();
    final photoUrl = firebaseUser?.photoURL?.trim();

    return MoodleScaffold(
      appBar: const MoodleAppBar(title: 'Profile'),
      backgroundColor: moodleBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = isWideScreen(context);

          final profileHeader = Column(
            children: [
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: moodleGrayBg,
                  backgroundImage:
                      photoUrl != null ? NetworkImage(photoUrl) : null,
                  child: photoUrl == null
                      ? const Icon(Icons.person, size: 52, color: moodlePurple)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  displayName?.isNotEmpty == true
                      ? displayName!
                      : 'Name not set',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: moodlePurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );

          final detailsCard = Card(
            color: moodleWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: moodleBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline, color: moodlePurple),
                  title: const Text('Display name'),
                  subtitle: Text(
                    displayName?.isNotEmpty == true
                        ? displayName!
                        : 'Not available',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email_outlined, color: moodlePurple),
                  title: const Text('Email'),
                  subtitle: Text(
                    email?.isNotEmpty == true ? email! : 'Not available',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.image_outlined, color: moodlePurple),
                  title: const Text('Profile photo'),
                  subtitle: Text(
                    photoUrl?.isNotEmpty == true
                        ? photoUrl!
                        : 'No photo set',
                  ),
                ),
              ],
            ),
          );

          final modulesCard = Card(
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
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              profileHeader,
              const SizedBox(height: 24),
              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: detailsCard),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enrolled modules',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: moodlePurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          modulesCard,
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                detailsCard,
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
                modulesCard,
              ],
            ],
          );
        },
      ),
    );
  }
}
