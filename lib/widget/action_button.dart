import 'package:flutter/material.dart';

enum PillButtonVariant { neutral, primaryGradient, destructive }

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PillButtonVariant.primaryGradient,
    this.height = 44,
    this.fullWidth = false,
    this.radius = 16,
    this.leading,
    this.trailing,
    this.loading = false,
    this.disabled = false,
    this.gradient, // override gradient jika perlu
  });

  final String label;
  final VoidCallback? onPressed;
  final PillButtonVariant variant;
  final double height;
  final bool fullWidth;
  final double radius;
  final Widget? leading;
  final Widget? trailing;
  final bool loading;
  final bool disabled;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bool isDisabled = disabled || loading || onPressed == null;

    // COLORS
    final Color brand = cs.primary; // warna brand (ungu kebiruan)
    final Color brand2 = cs.tertiary; // aksen (ungu/pink)
    final Color neutralBg = cs.surfaceContainerHighest; // abu
    final Color neutralText = brand; // teks ungu di tombol abu
    final Color destructiveBg = const Color(0xFFD32F2F); // merah
    final Color white = cs.onPrimary;

    // DECORATION per variant
    BoxDecoration deco;
    TextStyle textStyle =
        Theme.of(context).textTheme.labelLarge ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

    switch (variant) {
      case PillButtonVariant.neutral:
        deco = BoxDecoration(
          color: neutralBg,
          borderRadius: BorderRadius.circular(radius),
        );
        textStyle = textStyle.copyWith(
          color: isDisabled ? neutralText.withAlpha(120) : neutralText,
        );
        break;

      case PillButtonVariant.primaryGradient:
        deco = BoxDecoration(
          gradient:
              gradient ??
              LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  brand, // kiri
                  brand2, // kanan
                ],
              ),
          borderRadius: BorderRadius.circular(radius),
        );
        textStyle = textStyle.copyWith(
          color: white,
          fontWeight: FontWeight.w700,
        );
        break;

      case PillButtonVariant.destructive:
        deco = BoxDecoration(
          color: destructiveBg,
          borderRadius: BorderRadius.circular(radius),
        );
        textStyle = textStyle.copyWith(
          color: white,
          fontWeight: FontWeight.w600,
        );
        break;
    }

    // Disabled overlay (gunakan alpha)
    if (isDisabled) {
      deco = deco.copyWith(boxShadow: const []);
    }

    final Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    variant == PillButtonVariant.neutral ? neutralText : white,
                  ),
                ),
              )
            else if (leading != null) ...[
              IconTheme.merge(
                data: IconThemeData(
                  color:
                      (variant == PillButtonVariant.neutral)
                          ? neutralText
                          : white,
                  size: 18,
                ),
                child: leading!,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
            if (!loading && trailing != null) ...[
              const SizedBox(width: 8),
              IconTheme.merge(
                data: IconThemeData(
                  color:
                      (variant == PillButtonVariant.neutral)
                          ? neutralText
                          : white,
                  size: 18,
                ),
                child: trailing!,
              ),
            ],
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
            splashColor: Colors.white.withAlpha(24),
            highlightColor: Colors.white.withAlpha(18),
            child: content,
          ),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }
}
