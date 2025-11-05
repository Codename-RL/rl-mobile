// layout/widgets/bg_bubbles.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BgBubbles extends StatelessWidget {
  const BgBubbles({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: cs.surface)),
        Positioned(
          top: -210.72,
          left: -90.23,
          child: _circle(650, cs.tertiary, cs.surface),
        ),
        Positioned(
          top: -270.37,
          left: -320.3,
          child: _circle(880, cs.primary, cs.surface),
        ),
      ],
    );
  }

  Widget _circle(double d, Color c, Color bg) => Container(
    width: d,
    height: d,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [c.withAlpha(210), bg.withAlpha(0), bg.withAlpha(0)],
        stops: const [0.0, .30, 1.0],
        radius: 0.8,
      ),
    ),
  );
}

/// VARIAN: ada ikon SVG di depan gradient.
/// - Ikon TIDAK dijadikan parameter.
/// - Ikon TIDAK dipaksa ganti warna (tanpa colorFilter).
class BgBubblesWithIcon extends StatelessWidget {
  const BgBubblesWithIcon({super.key});

  // ganti path ini sesuai asetmu
  static const String _iconAsset = 'assets/icon/two_smile_sad_figure.svg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned.fill(child: BgBubbles()),
        // ikon di depan gradient, tidak interaktif
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: Alignment(-.6, -.670), // pojok kiri-atas
              child: _Icon(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      BgBubblesWithIcon._iconAsset,
      width: 135,
      height: 135,
      // tanpa colorFilter → warna asli SVG dipakai
      // fit: BoxFit.contain, // opsional
    );
  }
}
