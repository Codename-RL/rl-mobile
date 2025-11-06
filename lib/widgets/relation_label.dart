// lib/widgets/relation_label.dart
import 'package:flutter/material.dart';

class RelasiLabel extends StatelessWidget {
  const RelasiLabel({
    super.key,
    required this.label,
    this.color, // boleh null → fallback ke theme.primary
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    this.radius = 32,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });

  final String label;
  final Color? color;
  final EdgeInsets padding;
  final double radius;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = color ?? cs.primary; // fallback aman

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
            base.withAlpha(90),     // dari warna custom/primary
            cs.onPrimary,           // ke onPrimary
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        // border: Border.all(color: base.withAlpha(100), width: 1),
      ),
      child: Padding(
        padding: padding,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: base, // kontras tetap dari base
              ),
        ),
      ),
    );
  }
}
