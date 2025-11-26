import 'package:flutter/material.dart';

class PersonDetailTabs extends StatelessWidget {
  const PersonDetailTabs({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  /// 0 = Jurnal, 1 = Informasi, 2 = Linimasa
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Material(
      color: cs.surface,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TABS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TabItem(
                label: 'Jurnal',
                index: 0,
                isActive: currentIndex == 0,
                onTap: onChanged,
              ),
              _TabItem(
                label: 'Informasi',
                index: 1,
                isActive: currentIndex == 1,
                onTap: onChanged,
              ),
              _TabItem(
                label: 'Linimasa',
                index: 2,
                isActive: currentIndex == 2,
                onTap: onChanged,
              ),
            ],
          ),

          // garis halus di bawah bg (opsional)
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: cs.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 12,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final int index;
  final bool isActive;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: tt.titleSmall?.copyWith(
                color: isActive ? cs.primary : cs.onSurface.withAlpha(100),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? cs.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
