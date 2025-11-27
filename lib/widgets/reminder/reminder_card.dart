// lib/widgets/reminder/reminder_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.title, // "Jurnal" / "Ulang Tahun" / dll
    required this.remindAt,
    required this.personName,
    this.personPhotoUrl,
    this.isJournal = false,
    this.journalExcerpt,
    this.onTap,
  });

  final String title;
  final DateTime remindAt;
  final String personName;
  final String? personPhotoUrl;

  /// true kalau reminder ini dari jurnal
  final bool isJournal;

  /// Ringkasan isi jurnal (opsional, hanya dipakai jika [isJournal] = true)
  final String? journalExcerpt;

  final VoidCallback? onTap;

  String get _dateText {
    // format: Kamis, 14 November 2025
    return DateFormat('EEEE, d MMMM y', 'id_ID').format(remindAt);
  }

  String get _timeText {
    // format: 14.50
    return DateFormat('HH.mm').format(remindAt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final bg = cs.surface.withAlpha(235);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: cs.surface, // border pakai surface
                width: 1.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.primary.withAlpha(45), // shadow warna primary
                  blurRadius: 18,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Baris atas: title + jam
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: tt.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _timeText,
                      style: tt.labelSmall?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                /// Tanggal pengingat
                Text(
                  _dateText,
                  style: tt.labelSmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                /// Avatar + nama panggilan
                Row(
                  children: [
                    CircleAvatar(
                      
                      radius: 10,
                      backgroundColor: cs.primary.withAlpha(60),
                      backgroundImage: (personPhotoUrl == null ||
                              personPhotoUrl!.isEmpty)
                          ? null
                          : NetworkImage(personPhotoUrl!),
                      child: (personPhotoUrl == null ||
                              personPhotoUrl!.isEmpty)
                          ? Text(
                              personName.isNotEmpty
                                  ? personName[0].toUpperCase()
                                  : '?',
                              style: tt.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      personName,
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurface.withAlpha(180),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                /// Ringkasan jurnal (optional)
                if (isJournal && (journalExcerpt?.trim().isNotEmpty ?? false))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primary.withAlpha(25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        journalExcerpt!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurface,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
