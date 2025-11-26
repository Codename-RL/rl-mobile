import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/form/search_bar.dart';
import 'package:sapa_mobile/widgets/person/person_filter_sheet.dart';
import 'package:sapa_mobile/widgets/person/person_list_tile.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';


class PersonSearchPage extends StatefulWidget {
  const PersonSearchPage({super.key});

  @override
  State<PersonSearchPage> createState() => _PersonSearchPageState();
}

class _PersonSearchPageState extends State<PersonSearchPage> {
  final TextEditingController _searchC = TextEditingController();
  String _query = '';

  PersonSortMode _sortMode = PersonSortMode.asc;
  String? _filterRelation;
  String? _filterTag;

  // Dummy data sementara
  final List<PersonOption> _allPersons = [
    PersonOption(
      id: '1',
      name: 'Dwimas Nugraha',
      avatarUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
      relation: 'Teman',
      tags: ['godek', 'basong'],
    ),
    PersonOption(
      id: '2',
      name: 'Anisa Rahma',
      avatarUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      relation: 'Keluarga',
      tags: ['keluarga'],
    ),
    PersonOption(
      id: '3',
      name: 'Bagas Pratama',
      avatarUrl:
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
      relation: 'Teman',
      tags: ['godek'],
    ),
    // Additional samples to demonstrate many relations & tags
    for (int i = 4; i <= 40; i++)
      PersonOption(
        id: '$i',
        name: 'Person $i',
        avatarUrl:
            'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
        relation: (i % 5 == 0)
            ? 'Rekan Kerja'
            : (i % 4 == 0)
                ? 'Komunitas'
                : (i % 3 == 0)
                    ? 'Partner Bisnis'
                    : (i % 2 == 0)
                        ? 'Keluarga'
                        : 'Teman',
        tags: [
          if (i % 2 == 0) 'godek',
          if (i % 3 == 0) 'travel',
          if (i % 4 == 0) 'music',
          if (i % 5 == 0) 'work',
          'tag$i',
        ],
      ),
  ];

  List<String> get _availableRelations =>
      _allPersons.map((p) => p.relation).toSet().toList()..sort();

  List<String> get _availableTags =>
      _allPersons.expand((p) => p.tags).toSet().toList()..sort();

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  List<PersonOption> _computeFiltered() {
    Iterable<PersonOption> list = _allPersons;

    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where(
        (p) =>
            p.name.toLowerCase().contains(q) ||
            p.tags.any((t) => t.toLowerCase().contains(q)),
      );
    }

    if (_filterRelation != null) {
      list = list.where((p) => p.relation == _filterRelation);
    }
    if (_filterTag != null) {
      list = list.where((p) => p.tags.contains(_filterTag));
    }

    final arr = list.toList();
    arr.sort((a, b) =>
        _sortMode == PersonSortMode.asc ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final filtered = _computeFiltered();

    return FormScaffold(
      title: 'Pilih Orang',
      // tombol kanan tidak perlu (pilih via tap list), jadi null
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          AppSearchBar(
            controller: _searchC,
            hintText: 'Cari seseorang...',
            showFilter: true,
            onChanged: (v) => setState(() => _query = v),
            onFilterTap: () async {
              final res = await showPersonFilterSheet(
                context,
                initialSort: _sortMode,
                initialRelation: _filterRelation,
                initialTag: _filterTag,
                relationOptions: _availableRelations,
                tagOptions: _availableTags,
              );
              if (res != null) {
                setState(() {
                  _sortMode = res.sortMode;
                  _filterRelation = res.relation;
                  _filterTag = res.tag;
                });
              }
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ClipRect(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final person = filtered[index];
                  return PersonListTile(
                    person: person,
                    variant: PersonTileVariant.outline,
                    onTap: () => Get.back(result: person),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
