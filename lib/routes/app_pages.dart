import 'package:get/get.dart';
import 'package:sapa_mobile/routes/app_routes.dart';
import 'package:sapa_mobile/widget/circle_icon_button.dart';
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
      page: () => const MainScaffold(title: 'Jurnal', body: JournalPage()),
    ),
    GetPage(
      name: Routes.people,
      page:
          () => MainScaffold(
            title: 'Orang',
            action: CircleIconButton(
              asset: 'assets/icon/plus.svg',
              size: 36, // samakan dengan desain
              iconSize: 24,
              tone: CircleTone.primary, // atau primary
              tooltip: 'Tambah orang',
              onTap: () {
                // TODO: navigasi ke form tambah orang
              },
            ),
            body: PeoplePage(),
          ),
    ),
    GetPage(
      name: Routes.reminder,
      page: () => MainScaffold(title: 'Reminder', body: const ReminderPage()),
    ),
    // Halaman tanpa navbar
    GetPage(name: Routes.compose, page: () => const ComposePage()),
    GetPage(name: Routes.settings, page: () => const SettingPage()),
  ];
}
