import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    super.key,
    required this.iconAsset,
    this.onTap,
    this.size = 32,
    this.iconSize = 22,
    this.borderRadius = 8,
    this.tooltip,
    this.semanticLabel,
    this.borderWidth = 1.5,
  });

  final String iconAsset;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final double borderRadius;
  final String? tooltip;
  final String? semanticLabel;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = cs.primary;

    Widget btn = Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: primary, width: borderWidth),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconAsset,
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(primary, BlendMode.srcIn),
          ),
        ),
      ),
    );

    btn = Semantics(
      button: true,
      label: semanticLabel ?? tooltip,
      child: btn,
    );

    if (tooltip != null) {
      btn = Tooltip(message: tooltip!, child: btn);
    }

    return btn;
  }
}
