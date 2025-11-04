// nav/nav_controller.dart
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class NavController extends GetxController {
  final index = 0.obs;

  static const tabs = <String>[
    Routes.journal,
    Routes.people,
    Routes.compose,   // tombol tengah (NO navbar)
    Routes.reminder,
    Routes.settings,  // (NO navbar)
  ];

  @override
  void onReady() {
    super.onReady();
    _sync(Get.currentRoute);
    ever(Get.routing.obs, (_) => _sync(Get.currentRoute));
  }

  void _sync(String r) {
    final i = tabs.indexOf(r);
    if (i != -1 && i != index.value) index.value = i;
  }

  void go(int i) {
    if (i == index.value) return;
    index.value = i;
    Get.offNamed(tabs[i]);
  }
}
