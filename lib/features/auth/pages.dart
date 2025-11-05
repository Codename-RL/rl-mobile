// lib/features/auth/pages.dart
import 'package:get/get.dart';
import 'package:sapa_mobile/features/auth/pages/forgot_pass_page.dart';
import 'package:sapa_mobile/features/auth/pages/login_page.dart';
import 'package:sapa_mobile/features/auth/pages/otp_verify_page.dart';
import 'package:sapa_mobile/features/auth/pages/register_page.dart';
import 'package:sapa_mobile/features/auth/pages/reset_password_page.dart';
import 'routes.dart';


final authPages = <GetPage>[
  GetPage(name: AuthRoutes.login,    page: () => const LoginPage(),    transition: Transition.cupertino),
  GetPage(name: AuthRoutes.register, page: () => const RegisterPage(), transition: Transition.cupertino),
  GetPage(name: AuthRoutes.otp,      page: () => const OtpVerifyPage(),transition: Transition.cupertino),
  GetPage(name: AuthRoutes.reset,    page: () => const ResetPasswordPage(), transition: Transition.cupertino),
  GetPage(name: AuthRoutes.forgot,    page: () => const ForgotPasswordPage(), transition: Transition.cupertino),
];
