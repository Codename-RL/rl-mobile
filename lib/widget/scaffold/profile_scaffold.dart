import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widget/relation_label.dart';
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
  });

  final Widget body;
  final String label;
  final Color color;
  final Widget? action;
  final VoidCallback? onBack;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final content = Padding(padding: padding, child: body);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER: back left, label center, action right
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: SizedBox(
                height: 44,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back wajib (kiri)
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
                    // Label relasi (tengah)
                    RelasiLabel(
                      label: label,
                      color: color,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                      radius: 32,
                    ),
                    // Action opsional (kanan)
                    if (action != null)
                      Align(alignment: Alignment.centerRight, child: action!),
                  ],
                ),
              ),
            ),

            // BODY
            Expanded(
              child: scrollable ? SingleChildScrollView(child: content) : content,
            ),
          ],
        ),
      ),
    );
  }
}
