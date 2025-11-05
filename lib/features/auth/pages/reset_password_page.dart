import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/scaffold/auth_scaffold.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

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
                          'Ubah kata sandi anda',
                          style: tt.headlineSmall?.copyWith(color: ct.primary),
                        ),
                        
                        const SizedBox(height: 12),
                         AppTextField(
                          label: 'Kata sandi baru',
                          hintText: "Masukkan kata sandi baru",
                          type: AppTextFieldType.password,
                        ),
                       
                        const SizedBox(height: 12),
                         AppTextField(
                          label: 'Konfirmasi Kata sandi baru',
                          hintText: "Masukkan konfirmasi kata sandi baru",
                          type: AppTextFieldType.password,
                        ),
                       
                        // const SizedBox(height: 12),
                       
                        const SizedBox(height: 16),
                        const ActionButton(
                          label: 'Ubah',
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
