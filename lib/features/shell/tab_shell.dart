// features/shell/tab_shell.dart
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sapa_mobile/core/nav_controller.dart';
import 'package:sapa_mobile/features/journal/pages/journal_page.dart';
import 'package:sapa_mobile/features/people/pages/people_page.dart';
import 'package:sapa_mobile/features/reminder/pages/reminder_page.dart';
import 'package:sapa_mobile/features/shell/tab_controller.dart';
import 'package:sapa_mobile/widgets/scaffold/main_scaffold.dart';

import '../../widgets/button/circle_icon_button.dart';
// import '../../features/people/routes.dart'; // kalau mau ke halaman create

class TabShell extends StatelessWidget {
  const TabShell({super.key});

  @override
  Widget build(BuildContext context) {
    final tab = Get.put(TabControllerX(), permanent: true);
    Get.put(NavController(), permanent: true);

    const pages = [JournalPage(), PeoplePage(), ReminderPage()];
    const titles = ['Jurnal', 'Orang', 'Reminder'];

    return Obx(() {
      final i = tab.index.value;

      // === ACTION HANYA UNTUK PEOPLE TAB (index 1) ===
      Widget? action;
      if (i == 1) {
        action = CircleButton(
          iconAsset: 'assets/icon/plus.svg',
          variant: CircleBtnVariant.stroke, // sesuai style-mu
          size: 36,
          iconSize: 18,
          onTap: () {
            // contoh: ke halaman tambah orang (opsional)
            // Get.toNamed(PeopleRoutes.create); // atau buka bottom sheet, dll.
          },
        );
      }

      return MainScaffold(
        title: titles[i],
        action: action, // <— dikirim ke header kanan
        body: IndexedStack(index: i, children: pages),
      );
    });
  }
}
