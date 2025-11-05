import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/routes/app_routes.dart';
import 'package:sapa_mobile/widget/action_button.dart';
import 'package:sapa_mobile/widget/circle_icon_button.dart';
import 'package:sapa_mobile/widget/scaffold/form_scaffold.dart';
import 'package:sapa_mobile/widget/scaffold/main_scaffold.dart';
import '../modules/journal/journal_page.dart';
import '../modules/people/people_page.dart';
import '../modules/compose/compose_page.dart';
import '../modules/reminder/reminder_page.dart';
import '../modules/setting/setting_page.dart';
// import '../core/nav_controller.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.journal,
      transition: Transition.noTransition,
      page:
          () => const MainScaffold(
            title: 'Jurnal',
            pageKey: ValueKey('tab-journal'),
            body: JournalPage(),
          ),
    ),
    GetPage(
      name: Routes.people,
      transition: Transition.noTransition,
      page:
          () => MainScaffold(
            title: 'Orang',
            action: CircleButton(
              iconAsset: 'assets/icon/plus.svg',
              variant: CircleBtnVariant.stroke,
              size: 36,
              iconSize: 18,
              onTap: () {},
            ),
            pageKey: ValueKey('tab-people'),
            body: PeoplePage(),
          ),
    ),
    GetPage(
      name: Routes.reminder,
      transition: Transition.noTransition,
      page:
          () => MainScaffold(
            title: 'Reminder',
            pageKey: ValueKey('tab-reminder'),
            body: const ReminderPage(),
          ),
    ),
    // Halaman tanpa navbar
    GetPage(
      name: Routes.compose,
      page:
          () => FormScaffold(
            title: "Buat Jurnal",
            body: ComposePage(),
            action: ActionButton(
              label: "Unggah",
              onPressed: () {},
              height: 40,
              showShadow: true,
            ),
          ),
    ),
    // GetPage(name: Routes.compose, page: () => const ComposePage()),
    GetPage(name: Routes.settings, page: () => const SettingPage()),
  ];
}
