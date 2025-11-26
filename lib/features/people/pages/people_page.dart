import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/form/search_bar.dart';
import 'package:sapa_mobile/widgets/person/empty_people_card.dart';
import 'package:sapa_mobile/widgets/person/person_filter_sheet.dart';
import 'package:sapa_mobile/widgets/person/person_list_tile.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _searchC = TextEditingController();
  String _query = '';

  PersonSortMode _sortMode = PersonSortMode.asc;
  String? _filterRelation;
  String? _filterTag;

  final List<PersonOption> _allPeople = [
    const PersonOption(
      id: '1',
      name: 'Dwimas Nugraha',
      avatarUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
      relation: 'Teman',
      tags: ['godek', 'basong'],
    ),
    const PersonOption(
      id: '2',
      name: 'Anisa Rahma',
      avatarUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      relation: 'Keluarga',
      tags: ['keluarga'],
    ),
    const PersonOption(
      id: '3',
      name: 'Bagas Pratama',
      avatarUrl:
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
      relation: 'Teman',
      tags: ['godek'],
    ),
    for (int i = 4; i <= 20; i++)
      PersonOption(
        id: '$i',
        name: 'Person $i',
        avatarUrl:
            'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
        relation: i.isEven ? 'Keluarga' : 'Teman',
        tags: [
          if (i.isEven) 'godek',
          if (i % 3 == 0) 'travel',
          'tag$i',
        ],
      ),
  ];

  List<String> get _availableRelations =>
      _allPeople.map((p) => p.relation).toSet().toList()..sort();

  List<String> get _availableTags =>
      _allPeople.expand((p) => p.tags).toSet().toList()..sort();

  List<PersonOption> _filteredPeople() {
    Iterable<PersonOption> list = _allPeople;

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
    arr.sort(
      (a, b) => _sortMode == PersonSortMode.asc
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name),
    );
    return arr;
  }

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_allPeople.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            EmptyPeopleCard(
              onAddTap: () => Get.toNamed('/people/create'),
            ),
          ],
        ),
      );
    }

    final filtered = _filteredPeople();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        AppSearchBar(
          controller: _searchC,
          hintText: 'Cari seseorang...',
          showFilter: true,
          variant: AppSearchBarVariant.surface,
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
          child: filtered.isEmpty
              ? const Center(
                  child: Text('Tidak ada orang yang cocok'),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final person = filtered[i];
                    return PersonListTile(
                      person: person,
                      variant: PersonTileVariant.surface,
                      onTap: () => Get.toNamed('/people/${person.id}'),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
