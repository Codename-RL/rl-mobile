import 'package:get/get.dart';
import 'routes.dart';
import 'tab_shell.dart';

final shellPages = <GetPage>[
  GetPage(
    name: ShellRoutes.shell,
    page: () => const TabShell(),
    transition: Transition.noTransition,
  ),
];
