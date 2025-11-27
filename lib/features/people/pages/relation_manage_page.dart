import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/search_bar.dart';
import 'package:sapa_mobile/widgets/person/relation_create_bottom_sheet.dart';
import 'package:sapa_mobile/widgets/relation_label.dart';

import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';

class RelationManagePage extends StatefulWidget {
  const RelationManagePage({
    super.key,
    this.initialRelations,
    this.initialSelected,
  });

  final List<RelationOption>? initialRelations;
  final RelationOption? initialSelected;

  @override
  State<RelationManagePage> createState() => _RelationManagePageState();
}

class _RelationManagePageState extends State<RelationManagePage> {
  late final TextEditingController _searchC;
  late List<RelationOption> _relations;
  RelationOption? _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchC = TextEditingController();
    _relations = widget.initialRelations ??
        const [
          RelationOption(name: 'Teman', color: Color(0xFF42A5F5)),
          RelationOption(name: 'Keluarga', color: Color(0xFFAB47BC)),
          RelationOption(name: 'Rekan Kerja', color: Color(0xFF26A69A)),
          RelationOption(name: 'Pasangan', color: Color(0xFFEF5350)),
          RelationOption(name: 'Lainnya', color: Color(0xFFFFB300)),
        ];
    _selected = widget.initialSelected;
  }

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  void _submit() {
    Get.back(result: _selected);
  }

  Future<void> _addRelation() async {
    final created = await showRelationCreateBottomSheet(context);
    if (created == null) return;
    final existsIndex = _relations.indexWhere(
      (item) => item.name.toLowerCase() == created.name.toLowerCase(),
    );
    setState(() {
      if (existsIndex >= 0) {
        _relations[existsIndex] = created;
      } else {
        _relations.add(created);
      }
      _selected = created;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _relations.where((item) {
      if (_query.isEmpty) return true;
      return item.name.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return FormScaffold(
      title: 'Kelola Relasi',
      action: ActionButton(
        label: 'Pilih',
        onPressed: _selected == null ? null : _submit,
        height: 40,
        showShadow: true,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          AppSearchBar(
            controller: _searchC,
            hintText: 'Cari relasi...',
            showFilter: false,
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final relation = filtered[index];
                final isSelected = relation.name == _selected?.name;
                return InkWell(
                  onTap: () => setState(() => _selected = relation),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Row(
                      children: [
                        RelasiLabel(
                          label: relation.name,
                          color: relation.color,
                        ),
                        const Spacer(),
                        if (isSelected)
                          Icon(Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ActionButton(
            label: 'Tambah Relasi Baru',
            variant: PillButtonVariant.neutral,
            fullWidth: true,
            height: 48,
            showShadow: false,
            onPressed: _addRelation,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
