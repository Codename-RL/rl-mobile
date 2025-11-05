// layout/widgets/header_bar.dart
import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key, this.title, this.titleWidget, this.action});
  final String? title;
  final Widget? titleWidget;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Row(children: [
          Expanded(
            child: titleWidget ??
                Text(title ?? '',
                    style: tt.titleLarge?.copyWith(
                      color: cs.onSurface)),
          ),
          if (action != null) action!,
        ]),
      ),
    );
  }
}
