import 'package:get/get.dart';
import 'routes.dart';
import 'pages/setting_page.dart';

final settingPages = <GetPage>[
  GetPage(name: SettingRoutes.page, page: () => const SettingPage(),
    transition: Transition.cupertino),
];
