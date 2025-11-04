import 'package:get/get.dart';
import 'package:sapa_mobile/routes/app_routes.dart';
import 'package:sapa_mobile/widget/scaffold/main_scaffold.dart';
import '../modules/journal/journal_page.dart';
import '../modules/people/people_page.dart';
import '../modules/compose/compose_page.dart';
import '../modules/reminder/reminder_page.dart';
import '../modules/setting/setting_page.dart';
import '../core/nav_controller.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.journal,
      page: () => const MainScaffold(body: JournalPage(), title: 'Jurnal'),
      binding: BindingsBuilder(() {
        // pastikan hanya sekali diinisiasi di main.dart (lihat bawah)
      }),
    ),
    GetPage(
      name: Routes.people,
      page: () => const MainScaffold(body: PeoplePage(), title: 'Orang'),
    ),
    GetPage(
      name: Routes.reminder,
      page: () => const MainScaffold(body: ReminderPage(), title: 'Reminder'),
    ),

    // Halaman tanpa navbar
    GetPage(name: Routes.compose,  page: () => const ComposePage()),
    GetPage(name: Routes.settings, page: () => const SettingPage()),
  ];
  
}
