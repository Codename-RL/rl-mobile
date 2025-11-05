// layout/nav_scaffold.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widget/bg_bubbles.dart';
import 'package:sapa_mobile/widget/header_bar.dart';
import 'package:sapa_mobile/widget/navbar.dart';


class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.body,
    this.title,
    this.titleWidget,
    this.action,
  });

  final Widget body;
  final String? title;
  final Widget? titleWidget;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Positioned.fill(child: BgBubbles()),
        Column(children: [
          HeaderBar(title: title, titleWidget: titleWidget, action: action),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: body,
          )),
        ]),
      ]),
      bottomNavigationBar: const Navbar(),
    );
  }
}
