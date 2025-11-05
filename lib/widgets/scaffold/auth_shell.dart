import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/bg_bubbles.dart';

/// Shell sangat ringan untuk halaman Auth:
/// - TANPA Scaffold
/// - Hanya BgBubbles + SafeArea + padding
class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      children: [
        const Positioned.fill(child: BgBubbles()),
        // warna dasar permukaan tetap terasa
        Positioned.fill(child: ColoredBox(color: cs.surface.withAlpha(0))),
        SafeArea(
          child: Padding(padding: padding, child: child),
        ),
      ],
    );
  }
}
