// lib/widgets/relasi_label.dart
import 'package:flutter/material.dart';

class RelasiLabel extends StatelessWidget {
  const RelasiLabel({
    super.key,
    required this.label,
    required this.color, // warna custom (mis. hijau relasi)
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.radius = 28,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });

  final String label;
  final Color color;
  final EdgeInsets padding;
  final double radius;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // teks dibuat sedikit lebih gelap dari warna custom agar kontras
    final textColor = color;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
            color.withAlpha(90), // dari warna custom
            cs.onPrimary, // ke onPrimary (terlihat seperti contoh)
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        // garis halus memakai warna custom dengan alpha
        // border: Border.all(color: color, width: 1),
      ),
      child: Padding(
        padding: padding,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
            // letterSpacing: .2,
          ),
        ),
      ),
    );
  }

  // bantu gelapkan warna agar teks kontras
  // Color _darken(Color c, double amount) {
  //   final hsl = HSLColor.fromColor(c);
  //   final l = (hsl.lightness - amount).clamp(0.0, 1.0);
  //   return hsl.withLightness(l).toColor();
  // }
}
