// lib/widgets/form/app_search_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppSearchBarVariant { primary, surface }

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.showFilter = false,
    this.onFilterTap,
    this.variant = AppSearchBarVariant.primary,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  /// tampilkan icon filter di kanan atau tidak
  final bool showFilter;

  /// dipanggil ketika icon filter di-tap
  final VoidCallback? onFilterTap;
  final AppSearchBarVariant variant;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final bool isSurfaceVariant = variant == AppSearchBarVariant.surface;
    final Color bgColor =
        isSurfaceVariant ? cs.surface : cs.primary.withAlpha(20);
    final Color borderColor =
        isSurfaceVariant ? cs.outlineVariant : cs.primary.withAlpha(45);
    final Color iconColor = cs.primary;

    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
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
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
                  color: isSurfaceVariant
                      ? cs.onSurfaceVariant
                      : cs.onSurface.withAlpha(120),
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
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
