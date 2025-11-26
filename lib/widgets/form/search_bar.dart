// lib/widgets/form/app_search_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.showFilter = false,
    this.onFilterTap,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  /// tampilkan icon filter di kanan atau tidak
  final bool showFilter;

  /// dipanggil ketika icon filter di-tap
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: cs.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: cs.primary.withAlpha(45),
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),

          // Icon search dari SVG
          SvgPicture.asset(
            'assets/icon/search.svg', // ganti sesuai path SVG-mu
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),

          // TextField transparan di tengah
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hintText,
                hintStyle: tt.titleSmall?.copyWith(
                  color: cs.onSurface.withAlpha(120),
                ),
              ),
              style: tt.titleSmall?.copyWith(
                color: cs.onSurface,
              ),
            ),
          ),

          // Icon filter opsional di kanan
          if (showFilter)
            InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: onFilterTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 8),
                child: SvgPicture.asset(
                  'assets/icon/filter.svg', // ganti sesuai path SVG-mu
                  width: 32,
                  height: 32,
                  colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
                ),
              ),
            )
          else
            const SizedBox(width: 16),
        ],
      ),
    );
  }
}
