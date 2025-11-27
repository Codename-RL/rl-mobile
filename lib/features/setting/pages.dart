import 'package:get/get.dart';
import 'routes.dart';
import 'pages/setting_page.dart';
import 'pages/edit_user_page.dart';
import 'pages/change_password_page.dart';

final settingPages = <GetPage>[
  GetPage(
    name: SettingRoutes.page,
    page: () => const SettingPage(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: SettingRoutes.editProfile,
    page: () {
      final args = Get.arguments as Map<String, dynamic>? ?? const {};
      return EditUserPage(
        initialName: args['name'] as String?,
        initialEmail: args['email'] as String?,
      );
    },
    transition: Transition.cupertino,
  ),
  GetPage(
    name: SettingRoutes.changePassword,
    page: () => const ChangePasswordPage(),
    transition: Transition.cupertino,
  ),
];
