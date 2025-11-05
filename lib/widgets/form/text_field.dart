import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppTextFieldType { text, email, password }

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.type,
    this.controller,
    this.hintText,
    this.autofocus = false,
    this.enabled = true,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
  });

  final String label;
  final AppTextFieldType type;
  final TextEditingController? controller;
  final String? hintText;
  final bool autofocus;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _c =
      widget.controller ?? TextEditingController();

  bool _obscure = true;
  String? _error;
  bool _touched = false;

  @override
  void dispose() {
    if (widget.controller == null) _c.dispose();
    super.dispose();
  }

  void _validate(String v) {
    String? err;
    switch (widget.type) {
      case AppTextFieldType.text:
        err = v.trim().isEmpty ? 'Wajib diisi' : null;
        break;
      case AppTextFieldType.email:
        if (v.trim().isEmpty) {
          err = 'Wajib diisi';
        } else {
          final ok = RegExp(
            r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
            caseSensitive: false,
          ).hasMatch(v.trim());
          err = ok ? null : 'Email tidak valid';
        }
        break;
      case AppTextFieldType.password:
        if (v.isEmpty) err = 'Wajib diisi';
        // contoh aturan minimal
        if (err == null && v.length < 6) err = 'Min. 6 karakter';
        break;
    }
    setState(() => _error = err);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final radius = BorderRadius.circular(16);
    final border = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: cs.primary.withAlpha(90), width: 1.4),
    );

    final filledColor = cs.primary.withAlpha(18); // lembut seperti contoh

    final suffix = switch (widget.type) {
      AppTextFieldType.password => IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: cs.primary,
          ),
        ),
      _ => null,
    };

    final keyboard = switch (widget.type) {
      AppTextFieldType.email => TextInputType.emailAddress,
      AppTextFieldType.password => TextInputType.visiblePassword,
      AppTextFieldType.text => TextInputType.text,
    };

    final autofill = switch (widget.type) {
      AppTextFieldType.email => const [AutofillHints.email],
      AppTextFieldType.password => const [AutofillHints.password],
      AppTextFieldType.text => const <String>[],
    };

    final formatters = <TextInputFormatter>[
      if (widget.type == AppTextFieldType.email)
        FilteringTextInputFormatter.deny(RegExp(r"\s")),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Label
        Text(
          widget.label,
          style: tt.labelLarge?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Field
        Focus(
          onFocusChange: (f) {
            if (!f) {
              _touched = true;
              _validate(_c.text);
            }
          },
          child: TextField(
            controller: _c,
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            obscureText: widget.type == AppTextFieldType.password && _obscure,
            keyboardType: keyboard,
            autofillHints: autofill,
            inputFormatters: formatters,
            textInputAction: widget.textInputAction,
            onChanged: (v) {
              if (_touched) _validate(v);
              widget.onChanged?.call(v);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: filledColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  color: cs.primary, width: 1.6,
                ),
              ),
              disabledBorder: border,
              errorBorder: border.copyWith(
                borderSide: BorderSide(color: cs.error, width: 1.4),
              ),
              focusedErrorBorder: border.copyWith(
                borderSide: BorderSide(color: cs.error, width: 1.6),
              ),
              suffixIcon: suffix,
            ),
            style: tt.bodyLarge?.copyWith(color: cs.onSurface),
          ),
        ),

        // Error di kanan bawah field
        SizedBox(
          height: 22,
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: (_error != null) ? 1 : 0,
              child: Text(
                _error ?? '',
                style: tt.bodySmall?.copyWith(color: cs.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
