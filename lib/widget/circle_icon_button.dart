import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Tombol bulat dengan opsi:
/// - variant: filled (isi solid) / ghost (tanpa isi)
/// - tone: primary / tertiary / custom
/// - fillOpacity: transparansi isi (only for filled)
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.asset,
    this.onTap,
    this.size = 40,
    this.iconSize = 20,
    this.variant = CircleVariant.filled,
    this.tone = CircleTone.primary,
    this.customColor,
    this.tooltip,
    this.borderWidth = 2,
  });

  final String asset;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final CircleVariant variant;
  final CircleTone tone;
  final Color? customColor;
  // final double fillOpacity; // dipakai saat variant = filled
  final String? tooltip;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // pilih warna dasar dari tema/ custom
    final Color base = switch (tone) {
      CircleTone.primary => cs.primary,
      CircleTone.tertiary => cs.tertiary,
      CircleTone.custom => (customColor ?? cs.primary),
    };

    // final bool disabled = onTap == null;

    // warna ikon → gunakan base, atau redup saat disabled

    // ring
    final border = Border.all(color: base, width: borderWidth);

    final decoration = BoxDecoration(
      shape: BoxShape.circle,
      border: border,
      // fill solid (tanpa gradient)
      color: base.withAlpha(30),
    );

    final btn = InkResponse(
      onTap: onTap,
      customBorder: const CircleBorder(),
      radius: size,
      child: Container(
        width: size,
        height: size,
        decoration: decoration,
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(base, BlendMode.srcIn),
          ),
        ),
      ),
    );

    return tooltip != null ? Tooltip(message: tooltip!, child: btn) : btn;
  }
}

enum CircleVariant { filled, ghost }

enum CircleTone { primary, tertiary, custom }
