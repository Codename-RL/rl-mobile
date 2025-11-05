import 'package:get/get.dart';
import '../features/shell/tab_controller.dart';
import '../features/compose/routes.dart';
import '../features/setting/routes.dart';

class NavController extends GetxController {
  final index = 0.obs; // 0: Journal, 1: People, 2: Compose, 3: Reminder, 4: Settings

  void go(int i) {
    if (i == 2) { Get.toNamed(ComposeRoutes.page); return; }
    if (i == 4) { Get.toNamed(SettingRoutes.page); return; }

    index.value = i;
    final tab = Get.find<TabControllerX>();
    final stackIndex = (i == 3) ? 2 : i; // map ke IndexedStack (0,1,2)
    tab.setTab(stackIndex);
  }
}
