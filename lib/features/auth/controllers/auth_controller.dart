// modules/auth/controllers/auth_controller.dart
import 'package:get/get.dart';
import '../services/auth_api.dart';

class AuthController extends GetxController {
  AuthController(this.api);
  final AuthApi api;

  final loading = false.obs;

  Future<void> doLogin(String email, String pass) async {
    loading.value = true;
    try { await api.login(email, pass); /* nav -> home */ }
    finally { loading.value = false; }
  }

  Future<void> doRegister(String name, String email, String pass) async {
    loading.value = true;
    try { await api.register(name, email, pass); await api.sendOtp(email); /* nav -> OTP */ }
    finally { loading.value = false; }
  }

  Future<void> requestReset(String email) async {
    loading.value = true;
    try { await api.sendOtp(email); /* nav -> OTP (mode reset) */ }
    finally { loading.value = false; }
  }
}
