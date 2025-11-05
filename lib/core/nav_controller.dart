// nav_controller.dart
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class NavController extends GetxController {
  final index = 0.obs;

  static const tabs = <String>[
    Routes.journal,   // 0
    Routes.people,    // 1
    Routes.compose,   // 2 (NO navbar)
    Routes.reminder,  // 3
    Routes.settings,  // 4 (NO navbar)
  ];

  void go(int i) {
    // halaman TANPA navbar -> dorong ke stack (toNamed), jangan ganti index tab
    if (i == 2 || i == 4) {
      Get.toNamed(tabs[i]);
      return;
    }
    // halaman DENGAN navbar -> ganti tab + replace (offNamed)
    if (i != index.value) {
      index.value = i;
      Get.offNamed(tabs[i]);
    }
  }
}
