import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileLabel extends StatelessWidget {
  const ProfileLabel({
    super.key,
    required this.fullName,
    this.photoUrl,
    this.onTap,
    this.composeAsset = 'assets/icon/compose_stroke.svg',
    this.avatarSize = 20,
    this.composeSize = 18,
    this.gap = 7,
    this.avatarBorderWidth = .5,
    this.avatarBorderColor,
    this.showCompose = true,
    this.composeOverlap = 0.6,
  });

  // ...

  // ...

  final String fullName;
  final String? photoUrl;
  final VoidCallback? onTap;

  final String composeAsset;
  final double avatarSize;
  final double composeSize;
  final double gap;

  final double avatarBorderWidth;
  final Color? avatarBorderColor;

  final bool showCompose;
  final double composeOverlap;

  String _firstWord(String s) {
    final t = s.trim();
    if (t.isEmpty) return '';
    final i = t.indexOf(RegExp(r'\s+'));
    return (i <= 0) ? t : t.substring(0, i);
  }

  @override
  Widget build(BuildContext context) {
    final name = _firstWord(fullName);
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    Widget avatar() {


      final Widget img =
          (photoUrl != null && photoUrl!.trim().isNotEmpty)
              ? Image.network(
                photoUrl!,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Image.asset(
                      'assets/image/avatar_default.jpg',
                      fit: BoxFit.cover,
                    ),
              )
              : Image.asset(
                'assets/image/avatar_default.jpg',
                fit: BoxFit.cover,
              );

      // lebar border minimal 1.0 biar tetap kelihatan
      final double bw = avatarBorderWidth.clamp(1.0, avatarSize / 2).toDouble();

      return Container(
        width: avatarSize,
        height: avatarSize,
        padding: EdgeInsets.all(
          0,
        ), // <- penting: ruang untuk border-nya sendiri
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: (avatarBorderColor ?? cs.surface),
            width: bw,
          ),
        ),
        child: ClipOval(
          child: img,
        ), // foto bulat, nempel ke ring (tanpa “gap” ekstra)
      );
    }

    // Lebar stack dibuat agak lebih besar supaya area sentuh tidak kepotong
    final double stackWidth =
        showCompose
            ? composeSize + (avatarSize * (1.0 - composeOverlap))
            : avatarSize;

    final art = SizedBox(
      width: stackWidth,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showCompose)
            Positioned(
              left: 0,
              top: (avatarSize - composeSize) / 2,
              child: SvgPicture.asset(
                composeAsset,
                width: composeSize,
                height: composeSize,
              ),
            ),
          Positioned(
            left: showCompose ? composeSize - (avatarSize * composeOverlap) : 0,
            top: 0,
            child: avatar(),
          ),
        ],
      ),
    );

    final label = Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: tt.labelMedium?.copyWith(color: cs.onSurface),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [art, SizedBox(width: gap), Flexible(child: label)],
          ),
        ),
      ),
    );
  }
}
