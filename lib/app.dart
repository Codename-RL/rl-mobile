// app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'core/app_theme.dart';
import 'routes/app_pages.dart';
import 'features/splash/routes.dart';

class SapaApp extends StatelessWidget {
  const SapaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAPA',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: SplashRoutes.page, // start from splash, TabShell after
      getPages: AppPages.pages,
      defaultTransition: Transition.noTransition, // tab tak animasi route
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('en'), Locale('id', 'ID')],
    );
  }
}
