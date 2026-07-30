import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/providers/course_provider.dart';
import 'package:moodle/widgets/app_bar_widget.dart';
import 'package:moodle/widgets/course_card.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleAppBar(title: 'Courses'),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: Consumer<CourseProvider>(
        builder: (context, courseProvider, _) {
          if (courseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'My courses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name or code...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: moodleWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: moodleBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: moodleBorder),
                  ),
                ),
                onChanged: courseProvider.setSearchQuery,
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Favourites'),
                      selected: courseProvider.favouritesOnly,
                      onSelected: courseProvider.setFavouritesOnly,
                      selectedColor: moodlePurple.withValues(alpha: 0.15),
                      checkmarkColor: moodlePurple,
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('All terms'),
                      selected: courseProvider.termFilter == null,
                      onSelected: (_) => courseProvider.setTermFilter(null),
                      selectedColor: moodlePurple.withValues(alpha: 0.15),
                      checkmarkColor: moodlePurple,
                    ),
                    ...courseProvider.availableTerms.map((term) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: FilterChip(
                          label: Text(term),
                          selected: courseProvider.termFilter == term,
                          onSelected: (_) =>
                              courseProvider.setTermFilter(term),
                          selectedColor: moodlePurple.withValues(alpha: 0.15),
                          checkmarkColor: moodlePurple,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (courseProvider.courses.isEmpty)
                const Text(
                  'No courses match your search or filters.',
                  style: TextStyle(fontSize: 16, color: moodleTextMuted),
                )
              else
                ...courseProvider.courses.map(
                  (course) => CourseCard(course: course),
                ),
            ],
          );
        },
      ),
    );
  }
}
