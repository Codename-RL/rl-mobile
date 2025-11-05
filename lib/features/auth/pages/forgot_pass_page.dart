// lib/modules/auth/pages/login_page.dart
import 'package:flutter/material.dart';
import '../../../widgets/scaffold/auth_scaffold.dart';
import '../../../widgets/form/text_field.dart';
import '../../../widgets/button/action_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final ct = Theme.of(context).colorScheme;

    return AuthScaffold(
      scrollable: false, // <-- scroll & center kita atur sendiri di bawah
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              // paksa tinggi minimal = tinggi viewport agar bisa center vertikal
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // penting untuk center
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Lupa kata sandi',
                          style: tt.headlineSmall?.copyWith(color: ct.primary),
                        ),
                        
                        const SizedBox(height: 12),
                         AppTextField(
                          label: 'Email',
                          hintText: "Masukkan email anda",
                          type: AppTextFieldType.password,
                        ),
                       
                        // const SizedBox(height: 12),
                        
                       
                        const SizedBox(height: 16),
                        const ActionButton(
                          label: 'Kirim OTP',
                          height: 46,
                          showShadow: true,
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
     
    );
  }
}
