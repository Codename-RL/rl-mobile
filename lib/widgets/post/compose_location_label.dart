// lib/widgets/compose/compose_location_label.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComposeLocationLabel extends StatelessWidget {
  const ComposeLocationLabel({
    super.key,
    required this.text,
    this.onClear,
  });

  final String text;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cs.primary.withAlpha(12), // bg soft ungu
        border: Border.all(
          color: cs.primary.withAlpha(90),
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          // icon lokasi (filled)
          SvgPicture.asset(
            'assets/icon/location_mark.svg', // ganti sesuai path icon kamu
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),

          // teks lokasi
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: tt.labelLarge?.copyWith(
                color: cs.primary,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // tombol X untuk hapus lokasi (opsional)
          if (onClear != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClear,
              child: Icon(
                Icons.close_rounded,
                size: 18,
                color: cs.primary.withAlpha(200),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
