// lib/widgets/media/square_image_carousel.dart
import 'package:flutter/material.dart';

class SquareImageCarousel extends StatefulWidget {
  const SquareImageCarousel({
    super.key,
    required this.images,                // url/asset path
    this.radius = 20,
    this.placeholderAsset,               // opsional: asset fallback saat error
    this.onPageChanged,
  });

  final List<String> images;
  final double radius;
  final String? placeholderAsset;
  final ValueChanged<int>? onPageChanged;

  @override
  State<SquareImageCarousel> createState() => _SquareImageCarouselState();
}

class _SquareImageCarouselState extends State<SquareImageCarousel> {
  final _pc = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  Widget _buildImage(String src) {
    final img = src.startsWith('http')
        ? Image.network(
            src,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallback(),
          )
        : Image.asset(
            src,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallback(),
          );
    return img;
  }

  Widget _fallback() {
    if (widget.placeholderAsset != null) {
      return Image.asset(widget.placeholderAsset!, fit: BoxFit.cover);
    }
    return Container(color: Colors.black12);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 1, // 1:1 — semua slide sama
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // --- Slides ---
            PageView.builder(
              controller: _pc,
              itemCount: widget.images.length,
              onPageChanged: (i) {
                setState(() => _index = i);
                widget.onPageChanged?.call(i);
              },
              itemBuilder: (_, i) => _buildImage(widget.images[i]),
            ),

            // --- Indicators ---
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (i) {
                  final active = i == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 10 : 8,
                    height: active ? 10 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // aktif: gradasi primary→tertiary, pasif: abu lembut
                      gradient: active
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [cs.primary, cs.tertiary],
                            )
                          : null,
                      color: active ? null : cs.onSurface.withAlpha(90),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                color: cs.primary.withAlpha(90),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : const [],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
