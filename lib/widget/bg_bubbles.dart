// layout/widgets/bg_bubbles.dart
import 'package:flutter/material.dart';

class BgBubbles extends StatelessWidget {
  const BgBubbles({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: cs.surface)),
        Positioned(
          top: -240.72,
          left: -62.23,
          child: _circle(724, cs.tertiary, cs.surface),
        ),
        Positioned(
          top: -380.37,
          left: -432.3,
          child: _circle(980, cs.primary, cs.surface),
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
      colors: [c.withAlpha(210), bg.withAlpha(0),bg.withAlpha(0)],
      stops: const [0.0, .60, 1.0],
      radius: 0.8,
    ),
  ),
);

}
