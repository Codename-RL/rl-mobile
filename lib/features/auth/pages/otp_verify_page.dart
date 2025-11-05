import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/scaffold/auth_shell.dart';

class OtpVerifyPage extends StatelessWidget {
  const OtpVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return AuthShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text('Verifikasi OTP', style: tt.headlineSmall),
          const SizedBox(height: 16),
          const AppTextField(
            label: 'Kode OTP',
            type: AppTextFieldType.text,
            hintText: '6 digit',
          ),
          const SizedBox(height: 20),
          const ActionButton(
            label: 'Verifikasi',
            height: 44,
            showShadow: true,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
