// lib/modules/compose/pages/compose_page.dart
import 'package:flutter/material.dart';

import 'package:sapa_mobile/widgets/form/journal_image_picker.dart';

class ComposePage extends StatelessWidget {
  const ComposePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),

        // TODO: nanti ganti dengan people picker
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: cs.onPrimaryContainer.withAlpha(90),
              width: 1.4,
            ),
          ),
          child: Text(
            'Pilih orang',
            style: tt.labelLarge?.copyWith(
              color: cs.onSurface.withAlpha(80),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Area teks jurnal
        Expanded(
          child: TextField(
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              hintText: 'Apa yang anda pikirkan?',
              hintStyle: tt.bodyLarge?.copyWith(
                color: cs.onSurface.withAlpha(60),
              ),
              border: InputBorder.none,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ===== Image Picker di bawah (dekat keyboard) =====
        const ComposeImagePicker(),

        const SizedBox(height: 16),
      ],
    );
  }
}
