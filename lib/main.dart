// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/core/nav_controller.dart';
import 'app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Get.put(NavController(), permanent: true); // satu kali saja
  runApp(const SapaApp());
}
