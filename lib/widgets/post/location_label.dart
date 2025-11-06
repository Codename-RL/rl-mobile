// lib/widgets/label/location_label_svg.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationLabelSvg extends StatelessWidget {
  const LocationLabelSvg({
    super.key,
    required this.text,
    required this.svgAsset,         // contoh: 'assets/icon/location_marker.svg'
    this.onTap,
    this.iconSize = 10,
    this.gap = 2,
    this.color,                     // null = warna asli SVG, != null = tint
    this.bold = false,
  });

  final String text;
  final String svgAsset;
  final VoidCallback? onTap;
  final double iconSize;
  final double gap;
  final Color? color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color ?? Theme.of(context).colorScheme.primary,
          // fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
        );

    final icon = SvgPicture.asset(
      svgAsset,
      width: iconSize,
      height: iconSize,
      // tint hanya jika color != null
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );

    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(width: gap),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
        ),
      ],
    );

    if (onTap == null) return row;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: row,
        ),
      ),
    );
  }
}
