// lib/widgets/circle_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CircleBtnVariant { filled, stroke }

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.iconAsset,          // path SVG
    this.onTap,
    this.size = 40,                   // diameter
    this.iconSize = 20,               // ukuran ikon
    this.variant = CircleBtnVariant.filled,
    this.strokeWidth = 2,
    this.strokeBgAlpha = 28,          // bg alpha utk variant stroke (0..255)
    this.shadowBlur = 12,
    this.shadowOffset = const Offset(0, 0),
    this.semanticLabel,
    this.tooltip,
  });

  final String iconAsset;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final CircleBtnVariant variant;
  final double strokeWidth;
  final int strokeBgAlpha;            // hanya untuk stroke
  final double shadowBlur;            // hanya untuk filled
  final Offset shadowOffset;          // hanya untuk filled
  final String? semanticLabel;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Color primary = cs.primary;
    final Color onPrimary = cs.onPrimary;

    // Ikon SELALU warna primary
    final Color iconColor = primary;

    // Dekorasi per-varian
    BoxDecoration deco;
    switch (variant) {
      case CircleBtnVariant.filled:
        deco = BoxDecoration(
          shape: BoxShape.circle,
          color: onPrimary,                              // shape onPrimary
          boxShadow: [
            BoxShadow(                                   // shadow warna primary
              color: primary.withAlpha(56),              // ~22% (56/255)
              blurRadius: shadowBlur,
              offset: shadowOffset,
              spreadRadius: 0,
            ),
          ],
        );
        break;

      case CircleBtnVariant.stroke:
        deco = BoxDecoration(
          shape: BoxShape.circle,
          color: primary.withAlpha(strokeBgAlpha),       // shape primary dgn alpha
          border: Border.all(color: primary, width: strokeWidth),
          // no shadow
        );
        break;
    }

    final btn = Semantics(
      button: true,
      label: semanticLabel ?? tooltip,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: deco,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconAsset,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );

    return tooltip != null ? Tooltip(message: tooltip!, child: btn) : btn;
  }
}
