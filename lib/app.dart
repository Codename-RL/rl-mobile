// app.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class SapaApp extends StatelessWidget {
  const SapaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAPA',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: Routes.journal,
      getPages: AppPages.pages,
      
    );
  }
}
