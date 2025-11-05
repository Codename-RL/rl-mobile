// lib/modules/auth/pages/login_page.dart
import 'package:flutter/material.dart';
import '../../../widgets/scaffold/auth_scaffold.dart';
import '../../../widgets/form/text_field.dart';
import '../../../widgets/button/action_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                          'Masuk',
                          style: tt.headlineSmall?.copyWith(color: ct.primary),
                        ),
                        const SizedBox(height: 12),
                         AppTextField(
                          label: 'Email',
                          hintText: "Email anda",
                          type: AppTextFieldType.email,
                        ),
                        const SizedBox(height: 12),
                         AppTextField(
                          label: 'Kata sandi',
                          hintText: "Kata sandi anda",
                          type: AppTextFieldType.password,
                        ),
                        // const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: null,
                            child:  Text(
                              'Lupa kata sandi?',
                              style: tt.labelLarge?.copyWith(
                                color: ct.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const ActionButton(
                          label: 'Masuk',
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
      bottomArea: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Belum punya akun?', style: tt.bodyMedium?.copyWith(color: ct.onPrimaryContainer)),
          TextButton(onPressed: null, child: Text('Daftar', style: tt.labelLarge?.copyWith(color: ct.primary))),
        ],
      ),
    );
  }
}
