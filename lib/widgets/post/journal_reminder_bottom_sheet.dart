import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/date_time_picker.dart';
import 'package:sapa_mobile/widgets/form/repeat_dropdown.dart';

/// Fungsi helper untuk memanggil bottom sheet.
/// - [initialDateTime] & [initialRepeat] diisi kalau mode "edit pengingat"
/// - [onSubmit] dipanggil saat user tekan "Aktifkan / Simpan"
/// - [onDelete] != null → akan muncul tombol "Hapus Pengingat"
void showJournalReminderSheet(
  BuildContext context, {
  DateTime? initialDateTime,
  RepeatOption initialRepeat = RepeatOption.none,
  required void Function(DateTime? dateTime, RepeatOption repeat) onSubmit,
  VoidCallback? onDelete,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(sheetContext).maybePop(),
            child: const SizedBox.expand(),
          ),
        ),
        JournalReminderSheet(
          initialDateTime: initialDateTime,
          initialRepeat: initialRepeat,
          onSubmit: onSubmit,
          onDelete: onDelete,
        ),
      ],
    ),
  );
}

class JournalReminderSheet extends StatefulWidget {
  const JournalReminderSheet({
    super.key,
    this.initialDateTime,
    this.initialRepeat = RepeatOption.none,
    required this.onSubmit,
    this.onDelete,
  });

  final DateTime? initialDateTime;
  final RepeatOption initialRepeat;
  final void Function(DateTime? dateTime, RepeatOption repeat) onSubmit;
  final VoidCallback? onDelete;

  @override
  State<JournalReminderSheet> createState() => _JournalReminderSheetState();
}

class _JournalReminderSheetState extends State<JournalReminderSheet> {
  DateTime? _dateTime;
  late RepeatOption _repeat;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.initialDateTime;
    _repeat = widget.initialRepeat;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    final hasReminder = _dateTime != null;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // handle
                  Container(
                    width: 64,
                    height: 6,
                    decoration: BoxDecoration(
                      color: cs.outlineVariant.withAlpha(160),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // icon + title
                  SvgPicture.asset(
                    'assets/icon/bell_stroke.svg', // stroke bell
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Pengingat Jurnal',
                    style: tt.headlineSmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Aktifkan notifikasi untuk mengingatkan\nAnda pada jurnal ini',
                    style: tt.bodyMedium?.copyWith(
                      color: cs.onSurface.withAlpha(190),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // DateTime picker
                  DateTimePicker(
                    label: 'Kapan Anda ingin diingatkan',
                    placeholder: 'Pilih tanggal dan waktu',
                    allowTime: true,
                    // kalau mau ambil value real-time, boleh tambah onChanged
                  ),
                  const SizedBox(height: 16),

                  // Repeat picker
                  RepeatPicker(
                    label: 'Pengulangan Pengingat',
                    placeholder: 'Pilih pengulangan',
                    initial: _repeat,
                    onChanged: (v) {
                      setState(() => _repeat = v);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Tombol Batal + Simpan/Aktifkan
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: 'Batal',
                          variant: PillButtonVariant.neutral,
                          height: 48,
                          showShadow: false,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ActionButton(
                          label: hasReminder ? 'Simpan' : 'Aktifkan',
                          variant: PillButtonVariant.primaryGradient,
                          height: 48,
                          showShadow: true,
                          onPressed: () {
                            // untuk contoh sederhana, pakai DateTime.now kalau null
                            final dt = _dateTime ?? DateTime.now();
                            widget.onSubmit(dt, _repeat);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),

                  // Tombol Hapus Pengingat (hanya kalau onDelete != null)
                  if (widget.onDelete != null) ...[
                    const SizedBox(height: 16),
                    ActionButton(
                      label: 'Hapus Pengingat',
                      variant: PillButtonVariant.destructive,
                      height: 48,
                      fullWidth: true,
                      showShadow: false,
                      onPressed: () {
                        widget.onDelete?.call();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
