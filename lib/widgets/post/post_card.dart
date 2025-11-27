// lib/widgets/post/post_card.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/post/emotion_picker.dart';
import 'package:sapa_mobile/widgets/post/image_carousel.dart';
import 'package:sapa_mobile/widgets/post/journal_reminder.dart';
import 'package:sapa_mobile/widgets/post/location_label.dart';
import 'package:sapa_mobile/widgets/post/profile_label.dart';
import 'package:sapa_mobile/widgets/post/tag_list.dart';
import 'package:sapa_mobile/widgets/relation_label.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    // header
    required this.fullName,
    this.photoUrl,
    this.relationText,
    this.relationColor,
    required this.createdAt,

    // body
    this.locationText,
    this.locationSvg = 'assets/icon/location_mark.svg',
    required this.content,
    this.tags,
    this.images,

    // style
    this.radius = 16,
    this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 16),
    this.showShadow = true,
    this.shadowColor, // default pakai cs.primary
  });

  // Header
  final String fullName;
  final String? photoUrl;
  final String? relationText;
  final Color? relationColor;
  final DateTime createdAt;

  // Body
  final String? locationText; // optional
  final String locationSvg; // svg icon path
  final String content; // required
  final List<String>? tags; // optional
  final List<String>? images; // optional

  // Style
  final double radius;
  final EdgeInsetsGeometry padding;
  final bool showShadow;
  final Color? shadowColor;

  String _timeAgo(BuildContext context) {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inSeconds < 60) return 'baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit yang lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam yang lalu';

    int months =
        (now.year * 12 + now.month) - (createdAt.year * 12 + createdAt.month);
    if (months < 12) {
      if (months <= 0) months = 1;
      return '$months bulan yang lalu';
    }
    final years = (months / 12).floor();
    return '$years tahun yang lalu';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow:
            showShadow
                ? [
                  // shadow warna primary (soft glow)
                  BoxShadow(
                    color: (shadowColor ?? cs.primary).withAlpha(45),
                    blurRadius: 5,
                    spreadRadius: .5,
                    offset: const Offset(0, 0),
                  ),
                  // sedikit depth natural
                  // BoxShadow(
                  //   color: Colors.black.withAlpha(18),
                  //   blurRadius: 10,
                  //   offset: const Offset(0, 2),
                  // ),
                ]
                : const [],
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bungkus kiri dengan Flexible supaya tidak nabrak ke kanan
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileLabel(
                        fullName: fullName,
                        photoUrl: photoUrl,
                        // avatarSize: 32,
                        // composeSize: 46,
                        // gap: 10,-
                      ),
                      const SizedBox(width: 8),
                      if (relationText != null && relationText!.isNotEmpty)
                        Flexible(
                          // chip bisa memendek bila sempit
                          child: RelasiLabel(
                            label: relationText!,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            color: relationColor, // boleh null sekarang
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _timeAgo(context),
                  overflow: TextOverflow.ellipsis,
                  style: tt.labelSmall?.copyWith(
                    color: cs.onSurface.withAlpha(120),
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // ===== Lokasi (opsional) =====
            if (locationText != null && locationText!.trim().isNotEmpty) ...[
              LocationLabelSvg(
                text: locationText!,
                svgAsset: locationSvg,
                color: cs.primary,
              ),
              const SizedBox(height: 2),
            ],

            // ===== Konten =====
            Text(content, style: tt.bodySmall?.copyWith(color: cs.onSurface)),

            // ===== Tag (opsional) =====
            if (tags != null && tags!.isNotEmpty) ...[
              const SizedBox(height: 8),
              HashTagList(tags: tags!, color: cs.primary),
            ],

            // ===== Gambar (opsional) =====
            if (images != null && images!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SquareImageCarousel(images: images!, radius: 20),
              ),
            ],
            const SizedBox(height: 12),
            

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                // Tombol aksi lainnya bisa ditambahkan di sini
                JournalReminderIcon(),
                SizedBox(width: 4),
                EmotionPicker(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
