import 'package:get/get.dart';
import 'routes.dart';
import 'pages/journal_page.dart';

final journalPages = <GetPage>[
  GetPage(name: JournalRoutes.page, page: () => const JournalPage(),
    transition: Transition.noTransition),
];
