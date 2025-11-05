// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/core/nav_controller.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavController(), permanent: true); // satu kali saja
  runApp(const SapaApp());
}
