import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/scaffold/auth_shell.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return AuthShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text('Daftar', style: tt.headlineSmall),
          const SizedBox(height: 16),
          const AppTextField(label: 'Nama', type: AppTextFieldType.text),
          const SizedBox(height: 14),
          const AppTextField(label: 'Email', type: AppTextFieldType.email),
          const SizedBox(height: 14),
          const AppTextField(
            label: 'Kata sandi',
            type: AppTextFieldType.password,
          ),
          const SizedBox(height: 20),
          const ActionButton(
            label: 'Daftar',
            height: 44,
            showShadow: true,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
