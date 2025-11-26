import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/relation_label.dart';

class PersonOption {
  final String id;
  final String name;
  final String avatarUrl;
  final String relation;      // contoh: "Teman"
  final List<String> tags;    // contoh: ["godek", "basong"]

  const PersonOption({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.relation,
    this.tags = const [],
  });
}

enum PersonTileVariant {
  outline,
  gradient,
  surface,
}

class PersonListTile extends StatelessWidget {
  const PersonListTile({
    super.key,
    required this.person,
    this.variant = PersonTileVariant.outline,
    this.onTap,
  });

  final PersonOption person;
  final PersonTileVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final radius = BorderRadius.circular(16);

    final bool isGradient = variant == PersonTileVariant.gradient;
    final bool useSurfaceStyle = variant == PersonTileVariant.surface;

    final BoxDecoration decoration;
    if (isGradient) {
      decoration = BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          colors: [
            cs.primary.withAlpha(220),
            cs.secondary.withAlpha(220),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withAlpha(160),
          width: 2,
        ),
      );
    } else if (useSurfaceStyle) {
      decoration = BoxDecoration(
        borderRadius: radius,
        color: cs.surface.withAlpha(180),
        border: Border.all(
          color: cs.primary.withAlpha(50),
          width: 2,
        ),
      );
    } else {
      decoration = BoxDecoration(
        borderRadius: radius,
        color: cs.surface,
        border: Border.all(
          color: cs.primary.withAlpha(160),
          width: 2,
        ),
      );
    }

    final nameColor = isGradient ? Colors.white : cs.onSurface;
    final tagColor = isGradient ? Colors.white : cs.primary;
    final relationColor = Colors.green.shade600;

    final Widget tileContent = ClipRRect(
      borderRadius: radius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Ink(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              child: Row(
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Image.network(
                      person.avatarUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Nama + relation + tag
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name,
                          style: tt.titleSmall?.copyWith(
                            color: nameColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            // Relation chip
                            RelasiLabel(
                              label: person.relation,
                              color: relationColor,
                              radius: 999,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Tags
                            Expanded(
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 2,
                                children: person.tags
                                    .take(3)
                                    .map(
                                      (t) => Text(
                                        '#$t',
                                        style: tt.labelMedium?.copyWith(
                                          color: tagColor,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (!useSurfaceStyle) return tileContent;

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: cs.primary.withAlpha(24),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: tileContent,
    );
  }
}
