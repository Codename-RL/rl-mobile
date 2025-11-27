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
    this.isRequired = true,
  });

  final String label;
  final AppTextFieldType type;
  final TextEditingController? controller;
  final String? hintText;
  final bool autofocus;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;
  final bool isRequired;

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
    final trimmed = v.trim();
    if (!widget.isRequired && trimmed.isEmpty) {
      setState(() => _error = null);
      return;
    }

    String? err;
    switch (widget.type) {
      case AppTextFieldType.text:
        err = trimmed.isEmpty ? 'Wajib diisi' : null;
        break;
      case AppTextFieldType.email:
        if (trimmed.isEmpty) {
          err = 'Wajib diisi';
        } else {
          final ok = RegExp(
            r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
            caseSensitive: false,
          ).hasMatch(trimmed);
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
      borderSide: BorderSide(
        color: cs.onPrimaryContainer.withAlpha(90),
        width: 1.4,
      ),
    );

    final filledColor = cs.primary.withAlpha(20); // lembut seperti contoh

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
            color: cs.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),

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
              hintStyle: tt.labelLarge?.copyWith(
                color: cs.onSurface.withAlpha(80),
              ),
              filled: true,
              fillColor: filledColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15 ,
              ),
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  color: cs.secondary.withAlpha(150),
                  width: 2,
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

              // HANYA tampil kalau ada error & sudah pernah tersentuh
              errorText: _touched ? _error : null,
              // opsional: rapikan jarak
              isDense: true,
              errorStyle: tt.labelSmall?.copyWith(color: cs.error),
            ),

            style: tt.labelLarge?.copyWith(color: cs.onSurface.withAlpha(200)),
          ),
        ),

        // Error di kanan bawah field
      ],
    );
  }
}

class AppTextArea extends StatelessWidget {
  const AppTextArea({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.minLines = 3,
    this.maxLines = 6,
    this.enabled = true,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final radius = BorderRadius.circular(16);
    final border = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: cs.onPrimaryContainer.withAlpha(90),
        width: 1.4,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: tt.labelLarge?.copyWith(
            color: cs.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          enabled: enabled,
          minLines: minLines,
          maxLines: maxLines,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: tt.labelLarge?.copyWith(
              color: cs.onSurface.withAlpha(80),
            ),
            filled: true,
            fillColor: cs.primary.withAlpha(20),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(
                color: cs.secondary.withAlpha(150),
                width: 2,
              ),
            ),
            disabledBorder: border,
          ),
          style: tt.labelLarge?.copyWith(color: cs.onSurface.withAlpha(200)),
        ),
      ],
    );
  }
}
