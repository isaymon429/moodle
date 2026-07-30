import 'package:moodle/models/announcement.dart';
import 'package:moodle/models/assignment.dart';
import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/models/course.dart';

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

const _uxdiTopics = [
  Topic(
    title: 'Week 1: Introduction',
    resources: [
      'Lecture slides — Introduction.pdf',
      'Reading: UX basics',
      'Forum: Say hello',
    ],
  ),
  Topic(
    title: 'Week 2: Research methods',
    resources: [
      'Workshop handout.pdf',
      'Persona template.docx',
      'User interview guide',
    ],
  ),
  Topic(
    title: 'Week 3: Prototyping',
    resources: [
      'Figma starter file',
      'Wireframe checklist',
      'Peer review form',
    ],
  ),
  Topic(
    title: 'Coursework',
    resources: [
      'Moodle Flutter brief.pdf',
      'Marking criteria',
      'Demo booking link',
    ],
  ),
];

const _defaultTopics = [
  Topic(
    title: 'Week 1: Introduction',
    resources: ['Lecture slides.pdf', 'Reading list', 'Intro quiz'],
  ),
  Topic(
    title: 'Week 2: Core concepts',
    resources: ['Workshop notes.pdf', 'Lab worksheet', 'Discussion forum'],
  ),
];

const List<Course> dummyCourses = [
  Course(
    id: 'uxdi-2024',
    code: 'UXDI',
    name: 'User Experience Design & Implementation',
    instructor: 'Dr Mani Gahrmani',
    term: '2025/26 Semester 1',
    colorHex: '#5D2D5F',
    topics: _uxdiTopics,
    isFavourite: true,
  ),
  Course(
    id: 'papl-2024',
    code: 'PAPL',
    name: 'Programming and Problem Solving',
    instructor: 'Dr Sarah Chen',
    term: '2025/26 Semester 1',
    colorHex: '#0075FF',
    topics: _defaultTopics,
    isFavourite: true,
  ),
  Course(
    id: 'wd-2024',
    code: 'WD',
    name: 'Web Development',
    instructor: 'Prof James Wright',
    term: '2025/26 Semester 1',
    colorHex: '#2E7D32',
    topics: _defaultTopics,
  ),
  Course(
    id: 'dm-2024',
    code: 'DM',
    name: 'Database Management',
    instructor: 'Dr Emily Hughes',
    term: '2025/26 Semester 1',
    colorHex: '#E65100',
    topics: _defaultTopics,
  ),
  Course(
    id: 'cn-2024',
    code: 'CN',
    name: 'Computer Networks',
    instructor: 'Dr Ahmed Khan',
    term: '2025/26 Semester 2',
    colorHex: '#1565C0',
    topics: _defaultTopics,
  ),
];

final List<Assignment> dummyAssignments = [
  Assignment(
    id: 'asgn-1',
    courseId: 'uxdi-2024',
    title: 'Moodle Flutter Coursework',
    dueDate: DateTime(2026, 8, 15, 23, 59),
    status: AssignmentStatus.notSubmitted,
    description:
        'Recreate Moodle platform features in Flutter. Submit your GitHub fork link on Moodle and attend a live demo session.',
  ),
  Assignment(
    id: 'asgn-2',
    courseId: 'uxdi-2024',
    title: 'UX Portfolio Case Study',
    dueDate: DateTime(2026, 6, 20, 16, 0),
    status: AssignmentStatus.graded,
    grade: '72%',
    description:
        'Submit a case study documenting your UX process for a mobile app redesign.',
  ),
  Assignment(
    id: 'asgn-3',
    courseId: 'papl-2024',
    title: 'Lab 3 — Sorting Algorithms',
    dueDate: DateTime(2026, 7, 10, 12, 0),
    status: AssignmentStatus.submitted,
    description:
        'Implement and benchmark bubble, merge, and quick sort. Include unit tests.',
  ),
  Assignment(
    id: 'asgn-4',
    courseId: 'papl-2024',
    title: 'Lab 4 — Recursion',
    dueDate: DateTime(2026, 8, 1, 12, 0),
    status: AssignmentStatus.notSubmitted,
    description: 'Complete the recursion exercises and submit your lab report.',
  ),
  Assignment(
    id: 'asgn-5',
    courseId: 'wd-2024',
    title: 'Responsive Website Project',
    dueDate: DateTime(2026, 7, 25, 17, 0),
    status: AssignmentStatus.graded,
    grade: '68%',
    description:
        'Build a three-page responsive site using semantic HTML, CSS Grid, and minimal JavaScript.',
  ),
  Assignment(
    id: 'asgn-6',
    courseId: 'wd-2024',
    title: 'JavaScript DOM Exercise',
    dueDate: DateTime(2026, 8, 5, 17, 0),
    status: AssignmentStatus.submitted,
    description: 'Manipulate the DOM with vanilla JavaScript and submit your code.',
  ),
  Assignment(
    id: 'asgn-7',
    courseId: 'dm-2024',
    title: 'ER Diagram Submission',
    dueDate: DateTime(2026, 8, 8, 17, 0),
    status: AssignmentStatus.notSubmitted,
    description: 'Design and submit an ER diagram for the library database scenario.',
  ),
  Assignment(
    id: 'asgn-8',
    courseId: 'cn-2024',
    title: 'Network Protocols Report',
    dueDate: DateTime(2026, 7, 15, 14, 0),
    status: AssignmentStatus.graded,
    grade: '75%',
    description: 'Write a report comparing TCP and UDP for a given use case.',
  ),
];

final List<Announcement> dummyAnnouncements = [
  Announcement(
    id: 'ann-1',
    title: 'Coursework demo bookings open',
    body:
        'Book your 10-minute Moodle Flutter demo session via the link on the UXDI Moodle page.',
    date: DateTime(2026, 7, 20, 9, 0),
    courseId: 'uxdi-2024',
  ),
  Announcement(
    id: 'ann-2',
    title: 'Lab support session — Thursday',
    body:
        'Drop-in lab support for PAPL runs Thursday 2–4pm in Eldon Building room 1.12.',
    date: DateTime(2026, 7, 18, 14, 30),
    courseId: 'papl-2024',
  ),
  Announcement(
    id: 'ann-3',
    title: 'Library extended hours',
    body:
        'The university library will stay open until midnight during the assessment period.',
    date: DateTime(2026, 7, 15, 8, 0),
  ),
  Announcement(
    id: 'ann-4',
    title: 'Web Development lab moved',
    body:
        'This week\'s WD lab session has moved to room 2.04. Please bring your laptop.',
    date: DateTime(2026, 7, 22, 11, 0),
    courseId: 'wd-2024',
  ),
];

final List<CalendarEvent> dummyCalendarEvents = [
  CalendarEvent(
    id: 'cal-1',
    title: 'PAPL Lab 3 submission',
    date: DateTime(2026, 7, 3, 12, 0),
    type: CalendarEventType.deadline,
  ),
  CalendarEvent(
    id: 'cal-2',
    title: 'UXDI Workshop — Figma prototyping',
    date: DateTime(2026, 7, 7, 10, 0),
    type: CalendarEventType.event,
  ),
  CalendarEvent(
    id: 'cal-3',
    title: 'Computer Networks mid-term exam',
    date: DateTime(2026, 7, 10, 14, 0),
    type: CalendarEventType.exam,
  ),
  CalendarEvent(
    id: 'cal-4',
    title: 'WD Responsive site project deadline',
    date: DateTime(2026, 7, 14, 17, 0),
    type: CalendarEventType.deadline,
  ),
  CalendarEvent(
    id: 'cal-5',
    title: 'CN Protocols report deadline',
    date: DateTime(2026, 7, 15, 14, 0),
    type: CalendarEventType.deadline,
  ),
  CalendarEvent(
    id: 'cal-6',
    title: 'Database Management lecture',
    date: DateTime(2026, 7, 17, 13, 0),
    type: CalendarEventType.event,
  ),
  CalendarEvent(
    id: 'cal-7',
    title: 'PAPL drop-in support session',
    date: DateTime(2026, 7, 18, 14, 0),
    type: CalendarEventType.event,
  ),
  CalendarEvent(
    id: 'cal-8',
    title: 'UXDI coursework demo day',
    date: DateTime(2026, 7, 24, 9, 0),
    type: CalendarEventType.event,
  ),
  CalendarEvent(
    id: 'cal-9',
    title: 'Web Development lab test',
    date: DateTime(2026, 7, 28, 14, 0),
    type: CalendarEventType.exam,
  ),
  CalendarEvent(
    id: 'cal-10',
    title: 'Flutter Moodle Coursework Deadline',
    date: DateTime(2026, 8, 15, 23, 59),
    type: CalendarEventType.deadline,
  ),
];
