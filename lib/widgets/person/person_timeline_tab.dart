// lib/widgets/person/person_timeline_tab.dart
import 'package:flutter/material.dart';

class PersonTimelineItem {
  const PersonTimelineItem({
    required this.title,
    required this.createdAt,
  });

  final String title;
  final DateTime createdAt;
}

class PersonTimelineTab extends StatelessWidget {
  const PersonTimelineTab({
    super.key,
    required this.items,
  });

  final List<PersonTimelineItem> items;

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final isSameDay =
        dt.year == now.year && dt.month == now.month && dt.day == now.day;
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');

    if (isSameDay) return '$hh.$mm';

    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    final monthName = months[dt.month - 1];
    return '${dt.day} $monthName ${dt.year} $hh.$mm';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    if (items.isEmpty) {
      return Center(
        child: Text(
          'Belum ada aktivitas.',
          style: tt.bodyMedium?.copyWith(
            color: cs.onSurface.withAlpha(150),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isLast = index == items.length - 1;

        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 8 : 16,
            bottom: isLast ? 8 : 0,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _TimelineIndicator(
                  color: cs.primary,
                  showTopLine: index != 0,
                  showBottomLine: !isLast,
                  dashColor: cs.primary.withAlpha(140),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: cs.primary.withAlpha(45),
                          blurRadius: 5,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(item.createdAt),
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurface.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  const _TimelineIndicator({
    required this.color,
    required this.showTopLine,
    required this.showBottomLine,
    required this.dashColor,
  });

  final Color color;
  final Color dashColor;
  final bool showTopLine;
  final bool showBottomLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Column(
        children: [
          if (showTopLine)
            Flexible(
              flex: 1,
              child: _DashedLine(color: dashColor),
            )
          else
            const SizedBox(height: 8),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: 3,
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          if (showBottomLine)
            Flexible(
              flex: 1,
              child: _DashedLine(color: dashColor),
            )
          else
            const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _DashedLinePainter(color),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    const dashHeight = 6.0;
    const gap = 12.0;
    double y = 0;
    final double centerX = size.width / 2;
    while (y < size.height) {
      final double endY = (y + dashHeight).clamp(0, size.height);
      canvas.drawLine(Offset(centerX, y), Offset(centerX, endY), paint);
      y += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
