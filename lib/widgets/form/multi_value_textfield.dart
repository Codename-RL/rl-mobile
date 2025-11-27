// lib/widgets/form/multi_value_text_field.dart
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MultiFieldVariant { tagOrLink, email, phone }

const _defaultCountryCode = '+62';


// Tag / Link
class TagMultiField extends StatelessWidget {
  const TagMultiField({
    super.key,
    this.values = const [''],
    this.onChanged,
    this.label = 'Tag',
  });

  final List<String> values;
  final ValueChanged<List<String>>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MultiValueTextField(
      label: label,
      variant: MultiFieldVariant.tagOrLink,
      initialValues: values,
      onChanged: onChanged,
      hint: 'Tag',
    );
  }
}

// Email
class EmailMultiField extends StatelessWidget {
  const EmailMultiField({
    super.key,
    this.values = const [''],
    this.onChanged,
    this.label = 'Email',
  });

  final List<String> values;
  final ValueChanged<List<String>>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MultiValueTextField(
      label: label,
      variant: MultiFieldVariant.email,
      initialValues: values,
      onChanged: onChanged,
      hint: '@gmail.com',
    );
  }
}

// Nomor telepon
class PhoneMultiField extends StatelessWidget {
  const PhoneMultiField({
    super.key,
    this.values = const [''],
    this.onChanged,
    this.label = 'Nomor Telepon',
  });

  final List<String> values;
  final ValueChanged<List<String>>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MultiValueTextField(
      label: label,
      variant: MultiFieldVariant.phone,
      initialValues: values,
      onChanged: onChanged,
      hint: '0812 3456 7890',
    );
  }
}


class MultiValueTextField extends StatefulWidget {
  const MultiValueTextField({
    super.key,
    required this.label,
    required this.variant,
    this.initialValues = const [''],
    this.onChanged,
    this.hint,
  });

  final String label;
  final MultiFieldVariant variant;
  final List<String> initialValues;
  final ValueChanged<List<String>>? onChanged;
  final String? hint;

  @override
  State<MultiValueTextField> createState() => _MultiValueTextFieldState();
}

class _MultiValueTextFieldState extends State<MultiValueTextField> {
  final List<TextEditingController> _controllers = [];
  final List<String> _countryCodes = [];
  final List<String?> _errors = [];
  final RegExp _emailRegex = RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
    caseSensitive: false,
  );

  bool get _isPhone => widget.variant == MultiFieldVariant.phone;
  bool get _shouldValidate => widget.variant != MultiFieldVariant.tagOrLink;

  List<String> get _values {
    if (widget.variant != MultiFieldVariant.phone) {
      return _controllers.map((c) => c.text.trim()).toList();
    }
    return List.generate(_controllers.length, (index) {
      final value = _controllers[index].text.trim();
      final code =
          index < _countryCodes.length ? _countryCodes[index] : _defaultCountryCode;
      if (value.isEmpty) return '';
      return '$code $value'.trim();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValues.isEmpty) {
      _controllers.add(TextEditingController());
      if (_isPhone) {
        _countryCodes.add(_defaultCountryCode);
      }
      if (_shouldValidate) {
        _errors.add(_validateValue(_controllers.last.text));
      }
    } else {
      for (final v in widget.initialValues) {
        String value = v;
        String code = _defaultCountryCode;
        if (_isPhone) {
          final parsed = _splitPhoneValue(v);
          code = parsed.$1;
          value = parsed.$2;
        }
        _controllers.add(TextEditingController(text: value));
        if (_isPhone) {
          _countryCodes.add(code);
        }
        if (_shouldValidate) {
          _errors.add(_validateValue(value));
        }
      }
      if (_isPhone && _countryCodes.length != _controllers.length) {
        while (_countryCodes.length < _controllers.length) {
          _countryCodes.add(_defaultCountryCode);
        }
      }
    }

    if (_isPhone && _countryCodes.length < _controllers.length) {
      while (_countryCodes.length < _controllers.length) {
        _countryCodes.add(_defaultCountryCode);
      }
    }
    if (_shouldValidate && _errors.length < _controllers.length) {
      while (_errors.length < _controllers.length) {
        _errors.add(_validateValue(_controllers[_errors.length].text));
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _notifyChange() {
    widget.onChanged?.call(_values);
  }

  void _addField() {
    setState(() {
      _controllers.add(TextEditingController());
      if (_isPhone) {
        _countryCodes.add(_defaultCountryCode);
      }
      if (_shouldValidate) {
        _errors.add(null);
      }
    });
    _notifyChange();
  }

  void _removeField(int index) {
    if (_controllers.length <= 1) return;
    setState(() {
      final c = _controllers.removeAt(index);
      c.dispose();
      if (_isPhone && index < _countryCodes.length) {
        _countryCodes.removeAt(index);
      }
      if (_shouldValidate && index < _errors.length) {
        _errors.removeAt(index);
      }
    });
    _notifyChange();
  }

  TextInputType _keyboardType() {
    switch (widget.variant) {
      case MultiFieldVariant.tagOrLink:
        return TextInputType.text;
      case MultiFieldVariant.email:
        return TextInputType.emailAddress;
      case MultiFieldVariant.phone:
        return TextInputType.phone;
    }
  }

  String _defaultHint() {
    switch (widget.variant) {
      case MultiFieldVariant.tagOrLink:
        return 'Tag';
      case MultiFieldVariant.email:
        return '@gmail.com';
      case MultiFieldVariant.phone:
        return '0812 3456 7890';
    }
  }

  (String, String) _splitPhoneValue(String raw) {
    final trimmed = raw.trim();
    final match = RegExp(r'^\+?\d{1,4}').firstMatch(trimmed);
    if (match != null) {
      final code = match.group(0)!;
      final number = trimmed.substring(match.end).trimLeft();
      return (code, number);
    }
    return (_defaultCountryCode, trimmed);
  }

  void _pickCountry(int index) {
    if (widget.variant != MultiFieldVariant.phone) return;
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (country) {
        final dial = '+${country.phoneCode}';
        if (index >= _countryCodes.length) return;
        setState(() => _countryCodes[index] = dial);
        _notifyChange();
      },
    );
  }

  void _handleInputChanged(int index, String value) {
    if (_shouldValidate) {
      final error = _validateValue(value);
      setState(() {
        if (index >= _errors.length) {
          _errors.addAll(List.filled(index + 1 - _errors.length, null));
        }
        _errors[index] = error;
      });
    }
    _notifyChange();
  }

  String? _validateValue(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    switch (widget.variant) {
      case MultiFieldVariant.phone:
        return _validatePhone(trimmed);
      case MultiFieldVariant.email:
        return _emailRegex.hasMatch(trimmed) ? null : 'Email tidak valid';
      case MultiFieldVariant.tagOrLink:
        return null;
    }
  }

  String? _validatePhone(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    final digits = trimmed.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 6) return 'Nomor tidak valid';
    return null;
  }

  List<TextInputFormatter>? _inputFormatters() {
    switch (widget.variant) {
      case MultiFieldVariant.phone:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
        ];
      case MultiFieldVariant.email:
        return [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ];
      case MultiFieldVariant.tagOrLink:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final hint = widget.hint ?? _defaultHint();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label di atas
        Text(
          widget.label,
          style: tt.labelLarge?.copyWith(
            color: cs.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),

        // Semua field
        for (var i = 0; i < _controllers.length; i++) ...[
          _InputRow(
            controller: _controllers[i],
            hint: hint,
            variant: widget.variant,
            canRemove: _controllers.length > 1,
            onChanged: (value) => _handleInputChanged(i, value),
            onRemove: () => _removeField(i),
            keyboardType: _keyboardType(),
            inputFormatters: _inputFormatters(),
            countryCode: _isPhone && i < _countryCodes.length
                ? _countryCodes[i]
                : null,
            onCountryTap: _isPhone ? () => _pickCountry(i) : null,
            errorText: _shouldValidate && i < _errors.length ? _errors[i] : null,
          ),
          const SizedBox(height: 10),
        ],

        // Tombol "Tambah" di kanan bawah
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: _addField,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Tambah',
                style: tt.bodyMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Baris field tunggal + tombol "-"
class _InputRow extends StatelessWidget {
  const _InputRow({
    required this.controller,
    required this.hint,
    required this.variant,
    required this.canRemove,
    required this.onRemove,
    required this.onChanged,
    required this.keyboardType,
    this.countryCode,
    this.onCountryTap,
    this.errorText,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final MultiFieldVariant variant;
  final bool canRemove;
  final VoidCallback onRemove;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final String? countryCode;
  final VoidCallback? onCountryTap;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final borderColor = cs.onPrimaryContainer.withAlpha(90);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 52, minHeight: 52),
          child: Container(
            decoration: BoxDecoration(
              color: cs.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1.4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (variant == MultiFieldVariant.phone &&
                    countryCode != null &&
                    onCountryTap != null) ...[
                  _CountryChip(
                    code: countryCode!,
                    onTap: onCountryTap!,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 1,
                    height: 28,
                    color: cs.primary.withAlpha(80),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      isDense: true,
                      hintStyle: tt.labelLarge?.copyWith(
                        color: cs.onSurface.withAlpha(80),
                      ),
                    ),
                    style:
                        tt.labelLarge?.copyWith(color: cs.onSurface.withAlpha(200)),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
                if (canRemove) ...[
                  const SizedBox(width: 12),
                  IconButton(
                    iconSize: 22,
                    onPressed: onRemove,
                    color: cs.primary,
                    icon: const Icon(Icons.remove_circle_outline),
                    splashRadius: 22,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              errorText!,
              style: tt.labelSmall?.copyWith(color: cs.error),
            ),
          ),
      ],
    );
  }
}

class _CountryChip extends StatelessWidget {
  const _CountryChip({required this.code, required this.onTap});

  final String code;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: cs.primary.withAlpha(40),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              code,
              style: tt.bodyMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: cs.primary,
            ),
          ],
        ),
      ),
    );
  }
}
