import 'package:get/get.dart';
import '../routes/app_routes.dart';

class NavController extends GetxController {
  final index = 0.obs;

  // map index <-> route
  static const tabs = <String>[
    Routes.journal,
    Routes.people,
    Routes.compose,   // tombol tengah
    Routes.reminder,
    Routes.settings,
  ];

  @override
  void onInit() {
    super.onInit();
    _syncWithRoute(Get.currentRoute);
    ever(Get.routing.obs, (_) => _syncWithRoute(Get.currentRoute));
  }

  void _syncWithRoute(String r) {
    final i = tabs.indexOf(r);
    if (i != -1 && i != index.value) index.value = i;
  }


  void go(int i) {
    if (i == index.value) return;
    index.value = i;              // update state dulu biar Navbar langsung react
    Get.offNamed(tabs[i]);        // ganti halaman tanpa numpuk stack
  }
}
