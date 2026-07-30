class Course {
  const Course({
    required this.id,
    required this.code,
    required this.name,
    required this.instructor,
    required this.term,
    required this.colorHex,
  });

  final String id;
  final String code;
  final String name;
  final String instructor;
  final String term;
  final String colorHex;
}
