// lib/widgets/person/person_top_profile.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/bg_bubbles.dart';

class PersonTopProfile extends StatelessWidget {
  const PersonTopProfile({
    super.key,
    required this.name,
    this.photoUrl,
    this.tags = const [],
    this.height,
  });

  final String name;
  final String? photoUrl;
  final List<String> tags;
  final double? height;

  /// Perkiraan tinggi berdasarkan jumlah tag
  static double estimateHeight(List<String> tags) {
    const double base = 320; // avatar + nama tanpa tag
    if (tags.isEmpty) return base;

    // asumsi max 3 tag per baris
    final rows = (tags.length / 3).ceil();
    // setiap baris ekstra nambah ~28 px
    return base + (rows - 1) * 28;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final double h = height ?? estimateHeight(tags);

    return SizedBox(
      height: h,
      child: Stack(
        children: [
          const Positioned.fill(child: BgBubbles()),

          // konten di tengah, sedikit turun dari atas
          Align(
            alignment: const Alignment(0, 0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 100),
                Container(
                  width: 92,
                  height: 92,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: cs.surface,
                      width: 0,
                    ),
                    color: cs.surface,
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withAlpha(60),
                    backgroundImage: (photoUrl == null || photoUrl!.isEmpty)
                        ? null
                        : NetworkImage(photoUrl!),
                    child: (photoUrl == null || photoUrl!.isEmpty)
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: tt.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: tt.titleLarge?.copyWith(
                    color: cs.surface,
                    // fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: tags
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: cs.primary.withAlpha(40),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: cs.primary.withAlpha(115),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '#$t',
                              style: tt.labelMedium?.copyWith(
                                color: cs.primary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
