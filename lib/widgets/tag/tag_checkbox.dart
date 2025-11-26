// lib/widgets/tag/tag_checkbox.dart
import 'package:flutter/material.dart';

class TagCheckBox extends StatelessWidget {
  const TagCheckBox({super.key, required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: cs.primary,
          width: 2,
        ),
        color: checked ? cs.primary : Colors.transparent,
      ),
      child: checked
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }
}
