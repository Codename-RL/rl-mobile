// lib/modules/journal/pages/journal_page.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/icon_gradient_button.dart';
import 'package:sapa_mobile/widgets/post/post_card.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    // ---- dummy data (bisa ganti dari API) ----
    final posts = <PostCard>[
      PostCard(
        fullName: 'Dwimas Al Fulan',
        photoUrl: 'https://picsum.photos/200',
        relationText: 'Teman',
        relationColor: Colors.green,
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
        content:
            'Lorem ipsum asndajn dasndasndasm dnasmdn a asndajlsdajsdnadjsdnasd asdna jsdnjasn djandaw jdnasjdn adnasjndasjn dadnasjdn askj',
        tags: const ['sukil', 'muncak', 'liburan', 'jalanjalan', 'alam'],
      ),
      PostCard(
        fullName: 'Dwimas Al Fulan',
        photoUrl: 'https://picsum.photos/201',
        relationText: 'Teman',
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
        locationText: 'Universitas Mataram',
        content:
            'Lorem ipsum asndajn dasndasndasm dnasmdn a asndajlsdajsdnadjsdnasd asdna jsdnjasn djandaw jdnasjdn adnasjndasjn dadnasjdn askj',
      ),
      PostCard(
        fullName: 'Dwimas Al Fulan',
        photoUrl: 'https://picsum.photos/202',
        relationText: 'Teman',
        createdAt: DateTime.now().subtract(const Duration(minutes: 4)),
        locationText: 'Universitas Mataram',
        tags: const ['sukil', 'muncak', 'liburan', 'jalanjalan', 'alam'],
        content:
            'Lorem ipsum asndajn dasndasndasm dnasmdn a asndajlsdajsdnadjsdnasd asdna jsdnjasn djandaw jdnasjdn adnasjndasjn dadnasjdn askj',
        images: const [
          'https://picsum.photos/800/800?1',
          'https://picsum.photos/800/800?2',
          'https://picsum.photos/800/800?3',
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: IconGradientButton(
                label: 'Kalender',
                svgAsset: 'assets/icon/calendar.svg',
                onPressed: () {},
                height: 46,
                radius: 15,
                showShadow: false,
                showBorder: true,
                borderColor: cs.onPrimary.withAlpha(70),
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
                borderColor: cs.onPrimary.withAlpha(70),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Terbaru', style: tt.titleSmall?.copyWith(color: cs.primary)),
        const SizedBox(height: 6),

        // ---- list post scrollable ----
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 24, left: 4, right: 4, top:10),
            itemCount: posts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, i) => posts[i],
          ),
        ),
      ],
    );
  }
}
