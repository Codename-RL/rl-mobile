import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/scaffold/auth_shell.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return AuthShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text('Reset Password', style: tt.headlineSmall),
          const SizedBox(height: 16),
          const AppTextField(label: 'Email', type: AppTextFieldType.email),
          const SizedBox(height: 20),
          const ActionButton(
            label: 'Kirim OTP',
            height: 44,
            showShadow: true,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
