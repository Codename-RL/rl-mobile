import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/circle_icon_button.dart';

/// Scaffold ringan untuk halaman form/detail tanpa navbar.
/// - Back button (wajib)
/// - Title (opsional)
/// - Action kanan (opsional)
/// - Body bebas
/// - Hero opsional yang bisa menyatu dengan header (mirip ProfileScaffold)
class FormScaffold extends StatelessWidget {
  const FormScaffold({
    super.key,
    required this.body,
    this.title,
    this.action,
    this.onBack,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.scrollable = false,
    this.hero,
    this.heroHeight = 0,
    this.titleColor,
  });

  final Widget body;
  final String? title;
  final Widget? action;
  final VoidCallback? onBack;
  final EdgeInsetsGeometry padding;
  final bool scrollable;
  final Widget? hero;
  final double heroHeight;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final content = Padding(padding: padding, child: body);
    final double topInset = MediaQuery.of(context).padding.top;
    const double headerBlockHeight = 12 + 44 + 8 + 4;
    double heroSpacer = 0;
    if (hero != null && heroHeight > 0) {
      heroSpacer = heroHeight - headerBlockHeight - topInset;
      if (heroSpacer < 0) heroSpacer = 0;
    }

    return Scaffold(
      backgroundColor: cs.surface,
      body: Stack(
        children: [
          if (hero != null && heroHeight > 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: heroHeight,
              child: hero!,
            ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: Row(
                    children: [
                      CircleButton(
                        iconAsset: 'assets/icon/arrow_back.svg',
                        variant: CircleBtnVariant.filled,
                        size: 40,
                        iconSize: 22,
                        onTap: onBack ?? () => Get.back(),
                      ),
                      const SizedBox(width: 12),
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: tt.titleMedium?.copyWith(
                              color: titleColor ?? cs.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        const Spacer(),
                      if (action != null) action!,
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                if (heroSpacer > 0) SizedBox(height: heroSpacer),
                Expanded(
                  child:
                      scrollable
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
