import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/person/profile_photo_picker.dart';
import 'package:sapa_mobile/widgets/person/profile_photo_picker_mixin.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with ProfilePhotoPickerMixin<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _oldPasswordCtrl;
  late final TextEditingController _newPasswordCtrl;
  late final TextEditingController _confirmPasswordCtrl;

  @override
  void initState() {
    super.initState();
    _oldPasswordCtrl = TextEditingController();
    _newPasswordCtrl = TextEditingController();
    _confirmPasswordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final oldPassword = _oldPasswordCtrl.text;
    final newPassword = _newPasswordCtrl.text;
    final confirmPassword = _confirmPasswordCtrl.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Form belum lengkap',
        'Semua kolom kata sandi wajib diisi',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Kata sandi tidak cocok',
        'Konfirmasi kata sandi harus sama',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.back(
      result: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'photoPath': profileImagePath,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      title: 'Ganti Kata Sandi',
      action: ActionButton(
        label: 'Simpan',
        height: 40,
        showShadow: true,
        onPressed: _submit,
      ),
      scrollable: false,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    AppTextField(
                      label: 'Kata Sandi Lama',
                      controller: _oldPasswordCtrl,
                      type: AppTextFieldType.password,
                      hintText: 'Masukkan kata sandi lama',
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      label: 'Kata Sandi Baru',
                      controller: _newPasswordCtrl,
                      type: AppTextFieldType.password,
                      hintText: 'Masukkan kata sandi baru',
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      label: 'Konfirmasi Kata Sandi',
                      controller: _confirmPasswordCtrl,
                      type: AppTextFieldType.password,
                      textInputAction: TextInputAction.done,
                      hintText: 'Masukkan ulang kata sandi',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
