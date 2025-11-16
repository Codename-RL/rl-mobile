// lib/widgets/button/icon_gradient_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconGradientButton extends StatelessWidget {
  const IconGradientButton({
    super.key,
    required this.label,
    required this.svgAsset,
    required this.onPressed,
    this.height = 64,
    this.radius = 24,
    this.iconSize = 32,
    this.spacing = 8,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.gradient,
    this.iconColor,
    this.showShadow = true,
    this.shadowColor,
    // NEW — border
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.2,
    this.loading = false,
    this.disabled = false,
  });

  final String label;
  final String svgAsset;
  final VoidCallback? onPressed;

  final double height, radius, iconSize, spacing;
  final bool fullWidth;
  final EdgeInsetsGeometry padding;

  final Gradient? gradient;
  final Color? iconColor;
  final bool showShadow;
  final Color? shadowColor;

  // NEW — border
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;

  final bool loading, disabled;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDisabled = disabled || loading || onPressed == null;

    final deco = BoxDecoration(
      gradient:
          gradient ??
          
          LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [cs.primary, cs.tertiary],
          ),
      borderRadius: BorderRadius.circular(radius),
      border:
          showBorder
              ? Border.all(
                color: (borderColor ?? cs.onPrimary.withAlpha(70)),
                width: borderWidth,
              )
              : null,
      boxShadow:
          showShadow
              ? [
                BoxShadow(
                  color: (shadowColor ?? cs.primary).withAlpha(90),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
              : const [],
    );

    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: cs.onPrimary,
      fontWeight: FontWeight.w600,
    );

    final content = Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (loading)
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(cs.onPrimary),
                ),
              )
            else
              SvgPicture.asset(
                svgAsset,
                width: iconSize,
                height: iconSize,
                colorFilter:
                    iconColor == null
                        ? null
                        : ColorFilter.mode(iconColor!, BlendMode.srcIn),
              ),
            SizedBox(width: spacing),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );

    final child = DecoratedBox(
      decoration: deco,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: isDisabled ? null : onPressed,
            splashColor: Colors.white.withAlpha(30),
            highlightColor: Colors.white.withAlpha(20),
            child: content,
          ),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }
}
