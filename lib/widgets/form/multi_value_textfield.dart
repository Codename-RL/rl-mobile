// lib/widgets/form/multi_value_text_field.dart
import 'package:flutter/material.dart';

enum MultiFieldVariant {
  tagOrLink,
  email,
  phone,
}


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

  List<String> get _values =>
      _controllers.map((c) => c.text.trim()).toList();

  @override
  void initState() {
    super.initState();
    if (widget.initialValues.isEmpty) {
      _controllers.add(TextEditingController());
    } else {
      for (final v in widget.initialValues) {
        _controllers.add(TextEditingController(text: v));
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
    });
    _notifyChange();
  }

  void _removeField(int index) {
    if (_controllers.length <= 1) return;
    setState(() {
      final c = _controllers.removeAt(index);
      c.dispose();
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
          style: tt.titleSmall?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Semua field
        for (var i = 0; i < _controllers.length; i++) ...[
          _InputRow(
            controller: _controllers[i],
            hint: hint,
            variant: widget.variant,
            canRemove: _controllers.length > 1,
            onChanged: (_) => _notifyChange(),
            onRemove: () => _removeField(i),
            keyboardType: _keyboardType(),
          ),
          const SizedBox(height: 12),
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
  });

  final TextEditingController controller;
  final String hint;
  final MultiFieldVariant variant;
  final bool canRemove;
  final VoidCallback onRemove;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    const fieldHeight = 60.0;

    return Container(
      height: fieldHeight,
      decoration: BoxDecoration(
        color: cs.primary.withAlpha(10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: cs.primary.withAlpha(90),
          width: 1.4,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          // Prefix khusus nomor
          if (variant == MultiFieldVariant.phone) ...[
            Text(
              '+62 ▼',
              style: tt.bodyMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 1,
              height: 26,
              color: cs.primary.withAlpha(70),
            ),
            const SizedBox(width: 12),
          ],

          // TextField
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: tt.bodyMedium?.copyWith(
                  color: cs.onSurface.withAlpha(110),
                ),
              ),
              style: tt.bodyMedium?.copyWith(
                color: cs.onSurface,
              ),
            ),
          ),

          // Tombol "-" di sisi kanan
          if (canRemove) ...[
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cs.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(999),
              ),
              child: IconButton(
                iconSize: 22,
                padding: EdgeInsets.zero,
                onPressed: onRemove,
                icon: Icon(
                  Icons.remove_rounded,
                  color: cs.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
