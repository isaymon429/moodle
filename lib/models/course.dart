class CourseSection {
  const CourseSection({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<String> items;
}

class Course {
  const Course({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.colorHex,
    required this.sections,
  });

  final String id;
  final String code;
  final String title;
  final String description;
  final String colorHex;
  final List<CourseSection> sections;
}
