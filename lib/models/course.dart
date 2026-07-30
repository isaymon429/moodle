class Topic {
  const Topic({
    required this.title,
    required this.resources,
  });

  final String title;
  final List<String> resources;
}

class Course {
  const Course({
    required this.id,
    required this.code,
    required this.name,
    required this.instructor,
    required this.term,
    required this.colorHex,
    required this.topics,
    this.isFavourite = false,
  });

  final String id;
  final String code;
  final String name;
  final String instructor;
  final String term;
  final String colorHex;
  final List<Topic> topics;
  final bool isFavourite;
}
