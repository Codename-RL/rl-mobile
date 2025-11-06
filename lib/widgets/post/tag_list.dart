// lib/widgets/chips/hash_tag_list.dart
import 'package:flutter/material.dart';

class HashTagList extends StatelessWidget {
  const HashTagList({
    super.key,
    required this.tags,
    this.color,
    this.spacing = 4,
    this.runSpacing = 0,
    this.textStyle,
    this.wrap = true,          // false = single line + scroll horizontal
  });

  final List<String> tags;
  final Color? color;
  final double spacing;
  final double runSpacing;
  final TextStyle? textStyle;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final style = (textStyle ??
        Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color ?? cs.primary))!;

    final children = tags
        .where((t) => t.trim().isNotEmpty)
        .map((t) => Text('#${t.trim()}', style: style))
        .toList();

    if (wrap) {
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) SizedBox(width: spacing),
          ]
        ],
      ),
    );
  }
}
