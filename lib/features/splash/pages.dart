import 'package:get/get.dart';
import 'routes.dart';
import 'pages/splash_page.dart';

final splashPages = <GetPage>[
  GetPage(
    name: SplashRoutes.page,
    page: () => const SplashPage(),
    transition: Transition.fadeIn,
  ),
];
