// modules/auth/services/auth_api.dart
class AuthApi {
  Future<void> login(String email, String pass) async {/* TODO */}
  Future<void> register(String name, String email, String pass) async {/* TODO */}
  Future<void> sendOtp(String email) async {/* TODO */}
  Future<void> verifyOtp(String email, String code) async {/* TODO */}
  Future<void> resetPassword(String email, String newPass) async {/* TODO */}
}
