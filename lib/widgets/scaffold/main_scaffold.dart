// layout/nav_scaffold.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/bg_bubbles.dart';
import 'package:sapa_mobile/widgets/header_bar.dart';
import 'package:sapa_mobile/widgets/navbar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.body,
    this.title,
    this.titleWidget,
    this.action,
    this.pageKey, // <— tambahkan ini untuk identitas halaman
  });

  final Widget body;
  final String? title;
  final Widget? titleWidget;
  final Widget? action;
  final Key? pageKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Positioned.fill(child: BgBubbles()),
        Column(children: [
          HeaderBar(title: title, titleWidget: titleWidget, action: action),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              // ---- Transisi antar halaman (body saja) ----
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.bounceIn,
                switchOutCurve: Curves.bounceOut,
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                // penting: kunci berbeda per halaman/tab
                child: KeyedSubtree(
                  key: pageKey ?? ValueKey<String>(ModalRoute.of(context)?.settings.name ?? UniqueKey().toString()),
                  child: body,
                ),
              ),
            ),
          ),
        ]),
      ]),
      bottomNavigationBar: const Navbar(),
    );
  }
}
