import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widget/button/circle_icon_button.dart';
// import '../widgets/circle_icon_button.dart';

/// Scaffold ringan untuk halaman form/detail tanpa navbar.
/// - Back button (wajib)
/// - Title (opsional)
/// - Action kanan (opsional)
/// - Body bebas
class FormScaffold extends StatelessWidget {
  const FormScaffold({
    super.key,
    required this.body,
    this.title,
    this.action,
    this.onBack,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.scrollable = false,
  });

  final Widget body;
  final String? title; // opsional
  final Widget? action; // opsional (mis. tombol Simpan)
  final VoidCallback? onBack; // default: Get.back()
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final content = Padding(padding: padding, child: body);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  // Back (wajib)
                  CircleButton(
                    iconAsset: 'assets/icon/arrow_back.svg',
                    variant: CircleBtnVariant.filled,
                    size: 40,
                    iconSize: 22,
                    onTap: () => Get.back(),
                  ),
                  const SizedBox(width: 12),
                  // Title (opsional)
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: tt.titleMedium?.copyWith(
                          // fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  else
                    const Spacer(),
                  // Action (opsional)
                  if (action != null) action!,
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Body
            Expanded(
              child:
                  scrollable ? SingleChildScrollView(child: content) : content,
            ),
          ],
        ),
      ),
    );
  }
}
