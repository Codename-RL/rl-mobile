// layout/plain_scaffold.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/bg_bubbles.dart';
import 'package:sapa_mobile/widgets/header_bar.dart';


class PlainScaffold extends StatelessWidget {
  const PlainScaffold({
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: body,
          )),
        ]),
      ]),
    );
  }
}
