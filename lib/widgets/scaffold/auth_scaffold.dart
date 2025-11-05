// lib/widgets/scaffold/auth_scaffold.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/auth_bg_bubbles.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.body,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.scrollable = false,
    this.bottomArea,
  });

  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool scrollable;
  final Widget? bottomArea; // opsional: footer (mis. CTA kecil)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BgBubblesWithIcon()),
          SafeArea(
            child: Column(
              children: [
                // tidak ada HeaderBar
                Expanded(
                  child: Padding(
                    padding: padding,
                    child: scrollable
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: body,
                          )
                        : body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // tidak ada Navbar
      bottomNavigationBar: bottomArea == null
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: bottomArea,
              ),
            ),
    );
  }
}
