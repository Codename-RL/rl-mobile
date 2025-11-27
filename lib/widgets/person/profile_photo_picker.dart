import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({
    super.key,
    this.imageBytes,
    required this.isLoading,
    required this.onTap,
  });

  final Uint8List? imageBytes;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ImageProvider imageProvider = imageBytes != null
        ? MemoryImage(imageBytes!)
        : const AssetImage('assets/image/avatar_default.jpg');
    final borderColor = cs.primary.withAlpha(90);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          children: [
            Align(
              child: Container(
                width: 95,
                height: 95,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 3),
                ),
                child: ClipOval(
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (isLoading)
              Align(
                child: ClipOval(
                  child: Container(
                    width: 140,
                    height: 140,
                    color: Colors.black.withAlpha(100),
                    child: const Center(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 4,
              bottom: 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary,
                  border: Border.all(
                    color: cs.surface,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    'assets/icon/pen.svg',
                    width: 16,
                    height: 16,
                    colorFilter:
                        ColorFilter.mode(cs.surface, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
