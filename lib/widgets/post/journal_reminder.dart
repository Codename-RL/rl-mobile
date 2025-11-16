import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sapa_mobile/widgets/form/repeat_dropdown.dart';
import 'package:sapa_mobile/widgets/post/journal_reminder_bottom_sheet.dart';

class JournalReminderIcon extends StatefulWidget {
  const JournalReminderIcon({
    super.key,
    this.initialDateTime,
    this.initialRepeat = RepeatOption.none,
    this.onChanged,
    this.onDeleted,
  });

  final DateTime? initialDateTime;
  final RepeatOption initialRepeat;

  /// Dipanggil ketika user menekan "Aktifkan / Simpan"
  final void Function(DateTime? dateTime, RepeatOption repeat)? onChanged;

  /// Dipanggil ketika user menekan "Hapus Pengingat"
  final VoidCallback? onDeleted;

  @override
  State<JournalReminderIcon> createState() => _JournalReminderIconState();
}

class _JournalReminderIconState extends State<JournalReminderIcon> {
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
    final hasReminder = _dateTime != null;

    // ganti dengan path svg kamu sendiri
    final iconPath = hasReminder
        ? 'assets/icon/bell_fill.svg'
        : 'assets/icon/bell_stroke.svg';

    return GestureDetector(
      onTap: () {
        showJournalReminderSheet(
          context,
          initialDateTime: _dateTime,
          initialRepeat: _repeat,
          onSubmit: (dt, rp) {
            setState(() {
              _dateTime = dt;
              _repeat = rp;
            });
            widget.onChanged?.call(dt, rp);
          },
          onDelete: hasReminder
              ? () {
                  setState(() {
                    _dateTime = null;
                    _repeat = RepeatOption.none;
                  });
                  widget.onDeleted?.call();
                }
              : null,
        );
      },
      child: SvgPicture.asset(
        iconPath,
        width: 22,
        height: 22,
      ),
    );
  }
}
