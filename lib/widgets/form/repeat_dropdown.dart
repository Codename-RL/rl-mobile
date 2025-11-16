import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum RepeatOption { none, daily, weekly, monthly, yearly }

class RepeatPicker extends StatefulWidget {
  const RepeatPicker({
    super.key,
    this.label = 'Pengulangan pengingat',
    this.placeholder = 'Pilih pengulangan',
    this.initial,
    this.onChanged,
    this.iconAsset = 'assets/icon/repeat.svg',
  });

  final String label;
  final String placeholder;
  final RepeatOption? initial;
  final ValueChanged<RepeatOption>? onChanged;
  final String iconAsset; // svg di kiri

  @override
  State<RepeatPicker> createState() => _RepeatPickerState();
}

class _RepeatPickerState extends State<RepeatPicker> {
  RepeatOption? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial ?? RepeatOption.none;
  }

  String _labelOf(RepeatOption v) {
    switch (v) {
      case RepeatOption.none:
        return 'Tidak ada';
      case RepeatOption.daily:
        return 'Setiap hari';
      case RepeatOption.weekly:
        return 'Seminggu sekali';
      case RepeatOption.monthly:
        return 'Sebulan sekali';
      case RepeatOption.yearly:
        return 'Setahun sekali';
    }
  }

  Future<void> _openSheet() async {
    final cs = Theme.of(context).colorScheme;

    final picked = await showModalBottomSheet<RepeatOption>(
      context: context,
      backgroundColor: cs.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final opt in RepeatOption.values)
                ListTile(
                  title: Text(_labelOf(opt)),
                  trailing: _value == opt
                      ? Icon(Icons.radio_button_checked, color: cs.primary)
                      : Icon(Icons.radio_button_off,
                          color: cs.onSurface.withAlpha(120)),
                  onTap: () => Navigator.of(context).pop(opt),
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      setState(() => _value = picked);
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _openSheet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === LABEL (persis DateTimePicker) ===
          Text(
            widget.label,
            style: tt.labelLarge?.copyWith(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // === INPUT BOX (copy style DateTimePicker) ===
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: cs.onPrimaryContainer.withAlpha(90),
                width: 1.4,
              ),
              color: cs.primary.withAlpha(20),
            ),
            child: Row(
              children: [
                // SVG ikon kiri
                SvgPicture.asset(
                  widget.iconAsset,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                // Teks (placeholder / pilihan)
                Expanded(
                  child: Text(
                    (_value == null || _value == RepeatOption.none)
                        ? widget.placeholder
                        : _labelOf(_value!),
                    style: tt.labelLarge?.copyWith(
                      color: cs.onSurface.withAlpha(80),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
