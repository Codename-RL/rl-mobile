import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/person/profile_photo_picker.dart';
import 'package:sapa_mobile/widgets/person/profile_photo_picker_mixin.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, this.initialName, this.initialEmail});

  final String? initialName;
  final String? initialEmail;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage>
    with ProfilePhotoPickerMixin<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName ?? '');
    _emailCtrl = TextEditingController(text: widget.initialEmail ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_nameCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty) {
      Get.snackbar(
        'Form belum lengkap',
        'Nama dan email wajib diisi',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.back(
      result: {
        'name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'photoPath': profileImagePath,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      title: 'Sunting Profil',
      action: ActionButton(
        label: 'Simpan',
        height: 40,
        showShadow: true,
        onPressed: _submit,
      ),
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ProfilePhotoPicker(
                imageBytes: profileImageBytes,
                isLoading: isPickingAvatar,
                onTap: pickProfilePhoto,
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Nama',
              controller: _nameCtrl,
              type: AppTextFieldType.text,
              hintText: 'Masukkan nama lengkap',
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Email',
              controller: _emailCtrl,
              type: AppTextFieldType.email,
              hintText: 'nama@email.com',
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
