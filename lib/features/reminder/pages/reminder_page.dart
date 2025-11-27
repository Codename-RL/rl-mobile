import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/form/search_bar.dart';
import 'package:sapa_mobile/widgets/post/journal_reminder_bottom_sheet.dart';
import 'package:sapa_mobile/widgets/reminder/reminder_card.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  final List<Map<String, dynamic>> _reminders = [
    {
      'title': 'Ulang Tahun',
      'name': 'Dwimas Nugraha',
      'time': DateTime.now().add(const Duration(days: 2, hours: 3)),
      'isJournal': false,
    },
    {
      'title': 'Jurnal Harian',
      'name': 'Aira Lestari',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isJournal': true,
    },
    {
      'title': 'Follow-up Meeting',
      'name': 'Jamal',
      'time': DateTime.now().add(const Duration(days: 7)),
      'isJournal': false,
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final filtered = _reminders.where((reminder) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return (reminder['title'] as String).toLowerCase().contains(q) ||
          (reminder['name'] as String).toLowerCase().contains(q);
    }).toList();
    final nearest = filtered.isNotEmpty ? filtered.first : null;
    final newest =
        filtered.length > 1 ? filtered.sublist(1) : <Map<String, dynamic>>[];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          AppSearchBar(
            controller: _searchCtrl,
            hintText: 'Cari nama atau judul reminder',
            showFilter: false,
            variant: AppSearchBarVariant.surface,
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          Text(
            'Terdekat',
            style: tt.titleSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          if (nearest != null)
            ReminderCard(
              title: nearest['title'] as String,
              personName: nearest['name'] as String,
              remindAt: nearest['time'] as DateTime,
              isJournal: nearest['isJournal'] as bool? ?? false,
              onTap: () => _showReminderSheet(nearest),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Tidak ada reminder terdekat.',
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'Terbaru',
            style: tt.titleSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: newest.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada reminder terbaru.',
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.only(bottom: 24, left: 4, right: 4),
                    itemCount: newest.length,
                    itemBuilder: (context, index) {
                      final reminder = newest[index];
                      return ReminderCard(
                        title: reminder['title'] as String,
                        personName: reminder['name'] as String,
                        remindAt: reminder['time'] as DateTime,
                        isJournal: reminder['isJournal'] as bool? ?? false,
                        onTap: () => _showReminderSheet(reminder),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showReminderSheet(Map<String, dynamic> reminder) {
    final isJournal = reminder['isJournal'] as bool? ?? false;
    final title = isJournal ? 'Pengingat Jurnal' : 'Pengingat';
    final description = isJournal
        ? 'Aktifkan notifikasi untuk mengingatkan\nAnda pada jurnal ini'
        : 'Aktifkan pengingat untuk tanggal penting ini';
    showJournalReminderSheet(
      context,
      title: title,
      description: description,
      initialDateTime: reminder['time'] as DateTime?,
      onSubmit: (_, __) {},
      onDelete: () {
        Get.snackbar('Pengingat dihapus', reminder['title'] as String);
      },
    );
  }
}
