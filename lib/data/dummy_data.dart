import 'package:moodle/models/announcement.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/models/course.dart';

/// Hardcoded profile data — replace via [AuthService] when Firebase is added.
class DummyUserProfile {
  const DummyUserProfile({
    required this.fullName,
    required this.email,
    required this.upNumber,
    required this.initials,
    required this.programme,
    required this.cohort,
  });

  final String fullName;
  final String email;
  final String upNumber;
  final String initials;
  final String programme;
  final String cohort;
}

const dummyUserProfile = DummyUserProfile(
  fullName: 'MD SIMON ISLAM',
  email: 'up2201603@myport.ac.uk',
  upNumber: 'up2201603',
  initials: 'MS',
  programme: 'BSc (Hons) Computing',
  cohort: '2024/25',
);

final List<Course> dummyCourses = [
  const Course(
    id: 'uxdi-2024',
    code: 'UXDI',
    title: 'User Experience Design & Implementation',
    description:
        'Design and build user-centred digital products using research, prototyping, and Flutter.',
    colorHex: '#5D2D5F',
    sections: [
      CourseSection(
        id: 'uxdi-w1',
        title: 'Week 1 — Introduction to UX',
        items: [
          'Lecture slides: What is UX?',
          'Reading: Norman — The Design of Everyday Things (Ch. 1)',
        ],
      ),
      CourseSection(
        id: 'uxdi-w2',
        title: 'Week 2 — Research Methods',
        items: [
          'Workshop: Personas and user journeys',
          'Video: Conducting user interviews',
        ],
      ),
      CourseSection(
        id: 'uxdi-cw',
        title: 'Coursework — Moodle Flutter App',
        items: [
          'Brief: Recreate Moodle mobile features in Flutter',
          'Submission: GitHub repository link on Moodle',
          'Demo: Book a 10-minute online session',
        ],
      ),
    ],
  ),
  const Course(
    id: 'papl-2024',
    code: 'PAPL',
    title: 'Programming and Problem Solving',
    description:
        'Fundamentals of programming, algorithms, and software development practices.',
    colorHex: '#0075FF',
    sections: [
      CourseSection(
        id: 'papl-w1',
        title: 'Week 1 — Variables and Control Flow',
        items: [
          'Lecture: Data types and operators',
          'Lab: Your first console program',
        ],
      ),
      CourseSection(
        id: 'papl-w2',
        title: 'Week 2 — Functions and Testing',
        items: [
          'Workshop: Writing unit tests',
          'Reading: Clean Code — Functions (Ch. 3)',
        ],
      ),
    ],
  ),
  const Course(
    id: 'wd-2024',
    code: 'WD',
    title: 'Web Development',
    description:
        'Build responsive web applications with HTML, CSS, JavaScript, and modern frameworks.',
    colorHex: '#2E7D32',
    sections: [
      CourseSection(
        id: 'wd-w1',
        title: 'Week 1 — HTML & CSS Foundations',
        items: [
          'Lecture: Semantic HTML',
          'Lab: Flexbox layout exercise',
        ],
      ),
    ],
  ),
  const Course(
    id: 'dm-2024',
    code: 'DM',
    title: 'Database Management',
    description:
        'Relational modelling, SQL queries, and data integrity for application backends.',
    colorHex: '#E65100',
    sections: [
      CourseSection(
        id: 'dm-w1',
        title: 'Week 1 — ER Modelling',
        items: [
          'Lecture: Entities, attributes, relationships',
          'Worksheet: Design a library database schema',
        ],
      ),
    ],
  ),
];

final List<Assignment> dummyAssignments = [
  Assignment(
    id: 'asgn-moodle-cw',
    courseId: 'uxdi-2024',
    courseCode: 'UXDI',
    title: 'Moodle Flutter Coursework',
    dueDate: DateTime(2026, 8, 15, 23, 59),
    status: AssignmentStatus.inProgress,
    description:
        'Recreate Moodle platform features in Flutter. Submit your GitHub fork link on Moodle and attend a live demo.',
  ),
  Assignment(
    id: 'asgn-uxdi-portfolio',
    courseId: 'uxdi-2024',
    courseCode: 'UXDI',
    title: 'UX Portfolio Piece',
    dueDate: DateTime(2026, 6, 20, 16, 0),
    status: AssignmentStatus.submitted,
    description:
        'Submit a case study documenting your UX process for a mobile app redesign.',
  ),
  Assignment(
    id: 'asgn-papl-lab3',
    courseId: 'papl-2024',
    courseCode: 'PAPL',
    title: 'Lab 3 — Sorting Algorithms',
    dueDate: DateTime(2026, 5, 10, 12, 0),
    status: AssignmentStatus.overdue,
    description:
        'Implement and benchmark bubble, merge, and quick sort. Include unit tests.',
  ),
  Assignment(
    id: 'asgn-wd-project',
    courseId: 'wd-2024',
    courseCode: 'WD',
    title: 'Responsive Website Project',
    dueDate: DateTime(2026, 7, 1, 17, 0),
    status: AssignmentStatus.notStarted,
    description:
        'Build a three-page responsive site using semantic HTML, CSS Grid, and minimal JavaScript.',
  ),
];

final List<Announcement> dummyAnnouncements = [
  Announcement(
    id: 'ann-1',
    title: 'Coursework demo bookings open',
    message:
        'Book your 10-minute Moodle Flutter demo session via the link on the UXDI Moodle page. Deadline: 27 July.',
    date: DateTime(2026, 7, 20, 9, 0),
    isRead: false,
  ),
  Announcement(
    id: 'ann-2',
    title: 'Lab support session — Thursday',
    message:
        'Drop-in lab support for PAPL Lab 3 will run Thursday 2–4pm in Eldon Building room 1.12.',
    date: DateTime(2026, 7, 18, 14, 30),
    isRead: false,
  ),
  Announcement(
    id: 'ann-3',
    title: 'Welcome to the new term',
    message:
        'Check your timetable and module pages on Moodle. Contact your personal tutor if you have any questions.',
    date: DateTime(2026, 9, 15, 8, 0),
    isRead: true,
  ),
];

final List<CalendarEvent> dummyCalendarEvents = [
  CalendarEvent(
    id: 'cal-1',
    title: 'Moodle Flutter Coursework deadline',
    date: DateTime(2026, 8, 15, 23, 59),
    type: CalendarEventType.deadline,
    courseCode: 'UXDI',
  ),
  CalendarEvent(
    id: 'cal-2',
    title: 'UXDI Workshop — Prototyping in Figma',
    date: DateTime(2026, 7, 31, 10, 0),
    type: CalendarEventType.workshop,
    courseCode: 'UXDI',
  ),
  CalendarEvent(
    id: 'cal-3',
    title: 'PAPL Lecture — Recursion',
    date: DateTime(2026, 8, 5, 13, 0),
    type: CalendarEventType.lecture,
    courseCode: 'PAPL',
  ),
  CalendarEvent(
    id: 'cal-4',
    title: 'Web Development Lab Test',
    date: DateTime(2026, 8, 12, 14, 0),
    type: CalendarEventType.exam,
    courseCode: 'WD',
  ),
  CalendarEvent(
    id: 'cal-5',
    title: 'Database ER Diagram submission',
    date: DateTime(2026, 8, 8, 17, 0),
    type: CalendarEventType.deadline,
    courseCode: 'DM',
  ),
];
