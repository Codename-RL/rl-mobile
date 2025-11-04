import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final mode = ThemeMode.system.obs;

  void setLight()  { mode.value = ThemeMode.light;  Get.changeThemeMode(ThemeMode.light); }
  void setDark()   { mode.value = ThemeMode.dark;   Get.changeThemeMode(ThemeMode.dark); }
  void setSystem() { mode.value = ThemeMode.system; Get.changeThemeMode(ThemeMode.system); }
}
