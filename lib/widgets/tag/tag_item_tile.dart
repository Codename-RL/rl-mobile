// lib/widgets/tag/tag_item_tile.dart
import 'package:flutter/material.dart';

import 'tag_checkbox.dart';

class TagItemTile extends StatelessWidget {
  const TagItemTile({
    super.key,
    required this.tag,
    required this.selected,
    required this.onTap,
  });

  final String tag;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tag,
                style: tt.titleMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TagCheckBox(checked: selected),
          ],
        ),
      ),
    );
  }
}
