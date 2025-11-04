import 'package:get/get.dart';
import 'package:sapa_mobile/routes/app_routes.dart';
import '../modules/journal/journal_page.dart';
import '../modules/people/people_page.dart';
import '../modules/compose/compose_page.dart';
import '../modules/reminder/reminder_page.dart';
import '../modules/setting/setting_page.dart';
import '../nav/nav_controller.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: Routes.journal,  page: () => const JournalPage(),  binding: BindingsBuilder(() { Get.put(NavController(), permanent:true); })),
    GetPage(name: Routes.people,   page: () => const PeoplePage()),
    GetPage(name: Routes.compose,  page: () => const ComposePage()),
    GetPage(name: Routes.reminder, page: () => const ReminderPage()),
    GetPage(name: Routes.settings, page: () => const SettingPage()),
  ];
}
