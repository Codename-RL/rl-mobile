import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/relation_label.dart';
import '../button/circle_icon_button.dart';   // CircleButton 2-variant mu
          // widget label gradien

class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({
    super.key,
    required this.body,
    required this.label,         // teks label relasi (mis. "Teman")
    required this.color,         // warna custom untuk gradien
    this.action,                 // tombol kanan opsional
    this.onBack,                 // default: Get.back()
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.scrollable = false,
    this.hero,
    this.heroHeight = 0,
  });

  final Widget body;
  final String label;
  final Color color;
  final Widget? action;
  final VoidCallback? onBack;
  final EdgeInsetsGeometry padding;
  final bool scrollable;
  final Widget? hero;
  final double heroHeight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final content = Padding(padding: padding, child: body);

    return Scaffold(
      backgroundColor: cs.surface,
      body: Stack(
        children: [
          if (hero != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: heroHeight,
              child: hero!,
            ),
          SafeArea(
            child: Column(
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: SizedBox(
                    height: 44,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CircleButton(
                            iconAsset: 'assets/icon/arrow_back.svg',
                            variant: CircleBtnVariant.filled,
                            size: 40,
                            iconSize: 22,
                            onTap: onBack ?? () => Get.back(),
                          ),
                        ),
                        RelasiLabel(
                          label: label,
                          color: color,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          radius: 32,
                        ),
                        if (action != null)
                          Align(
                            alignment: Alignment.centerRight,
                            child: action!,
                          ),
                      ],
                    ),
                  ),
                ),
                if (hero != null) SizedBox(height: heroHeight),
                Expanded(
                  child: scrollable
                      ? SingleChildScrollView(child: content)
                      : content,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
