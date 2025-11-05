import 'package:get/get.dart';
import '../features/shell/pages.dart';
import '../features/auth/pages.dart';
import '../features/journal/pages.dart';
import '../features/people/pages.dart';
import '../features/reminder/pages.dart';
import '../features/compose/pages.dart';
import '../features/setting/pages.dart';

class AppPages {
  static final pages = <GetPage>[
    ...shellPages,     // '/'
    ...authPages,
    ...journalPages,
    ...peoplePages,
    ...reminderPages,
    ...composePages,
    ...settingPages,
  ];
}
