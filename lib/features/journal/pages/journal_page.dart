// lib/modules/journal/pages/journal_page.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/icon_gradient_button.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12), // jarak dari header
        Row(
          children: [
            Expanded(
              child: IconGradientButton(
                label: 'Kalender',
                svgAsset: 'assets/icon/calendar.svg',
                onPressed: () {},
                height: 46,
                radius: 15,
                showShadow: false, // di header gradien lebih rapi tanpa shadow
                showBorder: true,
                borderColor: Theme.of(context)
                    .colorScheme
                    .onPrimary
                    .withAlpha(70), // garis tipis
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IconGradientButton(
                label: 'Peta',
                svgAsset: 'assets/icon/map.svg',
                onPressed: () {},
                height: 46,
                radius: 15,
                showShadow: false,
                showBorder: true,
                borderColor: Theme.of(context)
                    .colorScheme
                    .onPrimary
                    .withAlpha(70),
              ),
            ),
          ],
        ),
        // …lanjutkan konten lain di bawah
      ],
    );
  }
}
