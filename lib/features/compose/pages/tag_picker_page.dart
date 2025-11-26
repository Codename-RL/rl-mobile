// lib/modules/compose/tag_picker_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/tag/tag_item_tile.dart';

import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/search_bar.dart';

class TagPickerPage extends StatefulWidget {
  const TagPickerPage({
    super.key,
    this.initialSelected = const [],
    this.initialTags,
  });

  /// Tag yang sudah terpilih sebelumnya
  final List<String> initialSelected;

  /// List tag yang tersedia; kalau null pakai dummy
  final List<String>? initialTags;

  @override
  State<TagPickerPage> createState() => _TagPickerPageState();
}

class _TagPickerPageState extends State<TagPickerPage> {
  final TextEditingController _searchC = TextEditingController();

  late final List<String> _tags;
  late final Set<String> _selected; // multi select
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tags = (widget.initialTags ??
            const ['#godek', '#basong', '#tempik'])
        .toList();
    _selected = widget.initialSelected.toSet();
  }

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  String _normalizeTag(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return '';
    if (t.startsWith('#')) return t;
    return '#$t';
  }

  void _onSubmit() {
    // kalau user mengetik sesuatu di search dan belum ada di list,
    // jadikan tag baru + otomatis terpilih
    if (_query.trim().isNotEmpty) {
      final newTag = _normalizeTag(_query);
      if (newTag.isNotEmpty && !_tags.contains(newTag)) {
        _tags.add(newTag);
      }
      if (newTag.isNotEmpty) {
        _selected.add(newTag);
      }
    }

    // kirim hasil ke caller
    Get.back(result: _selected.toList());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final filtered = _tags.where((t) {
      if (_query.isEmpty) return true;
      return t.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return FormScaffold(
      title: 'Pilih Tag',
      // Tombol "Pilih" di pojok kanan atas
      action: ActionButton(
        label: 'Pilih',
        height: 40,
        showShadow: true,
        onPressed: _onSubmit,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // Search / create tag
          AppSearchBar(
            controller: _searchC,
            hintText: 'Buat atau cari tag',
            onChanged: (v) => setState(() => _query = v),
            showFilter: false,
          ),
          const SizedBox(height: 12),

          // List tag
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: cs.primary.withAlpha(80),
              ),
              itemBuilder: (context, index) {
                final tag = filtered[index];
                final selected = _selected.contains(tag);

                return TagItemTile(
                  tag: tag,
                  selected: selected,
                  onTap: () {
                    setState(() {
                      if (selected) {
                        _selected.remove(tag);
                      } else {
                        _selected.add(tag);
                      }
                    });
                  },
                );
              },
            ),
          ),

          // opsional: info kecil di bawah
          // const SizedBox(height: 8),
          // Text(
          //   'Tag yang dipilih akan muncul di jurnal Anda.',
          //   style: tt.bodySmall?.copyWith(
          //     color: cs.onSurface.withAlpha(150),
          //   ),
          // ),
        ],
      ),
    );
  }
}
