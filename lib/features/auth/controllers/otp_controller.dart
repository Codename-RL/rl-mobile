// modules/auth/controllers/otp_controller.dart
import 'package:get/get.dart';
import '../services/auth_api.dart';

class OtpController extends GetxController {
  OtpController(this.api);
  final AuthApi api;

  final loading = false.obs;

  Future<void> verify(String email, String code, {bool isReset = false}) async {
    loading.value = true;
    try {
      await api.verifyOtp(email, code);
      if (isReset) {
        // lanjut ke set password baru
      } else {
        // selesai registrasi → login / home
      }
    } finally { loading.value = false; }
  }
}
