import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_theme.dart';
import 'core/theme_controller.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController(), permanent: true); // daftar sekali
  runApp(const SapaApp());
}

class SapaApp extends StatelessWidget {
  const SapaApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeC = Get.find<ThemeController>();
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAPA',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeC.mode.value, // ikut System, bisa dipaksa via tombol
      home: const HomePage(),
    ));
  }
}
