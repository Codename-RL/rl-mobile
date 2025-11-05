import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/features/auth/bindings/auth_binding.dart';
import 'package:sapa_mobile/features/auth/pages/login_page.dart';
import 'package:sapa_mobile/features/auth/pages/otp_verify_page.dart';
import 'package:sapa_mobile/features/auth/pages/register_page.dart';
import 'package:sapa_mobile/features/auth/pages/reset_password_page.dart';
import 'package:sapa_mobile/features/people/pages/person_detail_page.dart';
import 'package:sapa_mobile/routes/app_routes.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/button/circle_icon_button.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';
import 'package:sapa_mobile/widgets/scaffold/main_scaffold.dart';
import 'package:sapa_mobile/widgets/scaffold/profile_scaffold.dart';
import '../features/journal/pages/journal_page.dart';
import '../features/people/pages/people_page.dart';
import '../features/compose/pages/compose_page.dart';
import '../features/reminder/pages/reminder_page.dart';
import '../features/setting/pages/setting_page.dart';
// import '../core/nav_controller.dart';

class AppPages {
  static final pages = <GetPage>[
    // Navigasi dengan navbar
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
      transition: Transition.cupertino,
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

    // PEOPLE
    GetPage(
      name: Routes.personDetail,
      transition: Transition.cupertino,
      page: () {
        final id = Get.parameters['id']!; // ambil dari URL
        // (opsional) ambil data orang by id dari service/controller di sini

        return ProfileScaffold(
          label: 'Teman', // set sesuai data relasi orang
          color: const Color(0xFF548F21), // warna label relasi (custom)
          action: CircleButton(
            iconAsset: 'assets/icon/three_dots.svg',
            variant: CircleBtnVariant.filled,
            size: 40,
            iconSize: 22,
            onTap: () {
              /* menu */
            },
          ),
          body: PersonDetailPage(id: id), // konten detail
          scrollable: true,
        );
      },
    ),

    // AUTH
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: AuthBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpVerifyPage(),
      binding: AuthBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.reset,
      page: () => const ResetPasswordPage(),
      binding: AuthBindings(),
      transition: Transition.cupertino,
    ),
  ];
}
