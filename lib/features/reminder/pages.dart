// lib/features/reminder/pages.dart
import 'package:get/get.dart';
import 'routes.dart';
import 'pages/reminder_page.dart';

final reminderPages = <GetPage>[
  GetPage(
    name: ReminderRoutes.page,
    page: () => const ReminderPage(),
    transition: Transition.noTransition,
  ),
];
