// modules/auth/bindings/auth_bindings.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/otp_controller.dart';
import '../services/auth_api.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthApi>(() => AuthApi());
    Get.lazyPut<AuthController>(() => AuthController(Get.find()));
    Get.lazyPut<OtpController>(() => OtpController(Get.find()));
  }
}
