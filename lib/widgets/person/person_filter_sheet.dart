import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';

enum PersonSortMode { asc, desc }

class PersonFilterResult {
  final PersonSortMode sortMode;
  final String? relation; // contoh: "Teman", "Keluarga", dst
  final String? tag;      // filter single tag sederhana

  const PersonFilterResult({
    required this.sortMode,
    this.relation,
    this.tag,
  });
}

Future<PersonFilterResult?> showPersonFilterSheet(
  BuildContext context, {
  required PersonSortMode initialSort,
  String? initialRelation,
  String? initialTag,
  List<String> relationOptions = const ['Teman', 'Keluarga', 'Pasangan'],
  List<String> tagOptions = const ['godek', 'basong'],
}) {
  return showModalBottomSheet<PersonFilterResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      final tt = Theme.of(ctx).textTheme;

      PersonSortMode sort = initialSort;
      String? relation = initialRelation;
      String? tag = initialTag;

      final List<String> relationChoices = relationOptions
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .where((e) => e.toLowerCase() != 'semua')
          .toSet()
          .toList();
      final List<String> tagChoices = tagOptions
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .where((e) => e.toLowerCase() != 'semua')
          .toSet()
          .toList();

      return StatefulBuilder(
        builder: (ctx, setState) {
          final media = MediaQuery.of(ctx);
          final bottomInset = media.viewInsets.bottom;
          final maxHeight = media.size.height * 0.88;

          final content = Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 6,
                          decoration: BoxDecoration(
                            color: cs.outlineVariant.withAlpha(160),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Icon(
                          Icons.filter_alt_rounded,
                          size: 40,
                          color: cs.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Filter Orang',
                          style: tt.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sesuaikan tampilan daftar kontak sesuai kebutuhanmu.',
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Flexible(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SectionTitle(
                                  title: 'Urutkan nama',
                                  subtitle:
                                      'Atur urutan tampilan daftar kontak.',
                                ),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 10,
                                  children: [
                                    _FilterChip(
                                      label: 'A → Z',
                                      selected: sort == PersonSortMode.asc,
                                      onTap: () => setState(
                                          () => sort = PersonSortMode.asc),
                                    ),
                                    _FilterChip(
                                      label: 'Z → A',
                                      selected: sort == PersonSortMode.desc,
                                      onTap: () => setState(
                                          () => sort = PersonSortMode.desc),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                _SectionTitle(
                                  title: 'Relasi',
                                  subtitle:
                                      'Filter berdasarkan hubungan kamu.',
                                ),
                                _ChipWrap(
                                  children: [
                                    _FilterChip(
                                      label: 'Semua',
                                      selected: relation == null,
                                      onTap: () =>
                                          setState(() => relation = null),
                                    ),
                                    ...relationChoices.map(
                                      (item) => _FilterChip(
                                        label: item,
                                        selected: relation == item,
                                        onTap: () =>
                                            setState(() => relation = item),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                _SectionTitle(
                                  title: 'Tag',
                                  subtitle:
                                      'Pilih tag favorit untuk fokus cepat.',
                                ),
                                _ChipWrap(
                                  children: [
                                    _FilterChip(
                                      label: 'Semua',
                                      selected: tag == null,
                                      onTap: () =>
                                          setState(() => tag = null),
                                    ),
                                    ...tagChoices.map(
                                      (item) => _FilterChip(
                                        label: _formatTagLabel(item),
                                        selected: tag == item,
                                        onTap: () =>
                                            setState(() => tag = item),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ActionButton(
                                label: 'Reset',
                                variant: PillButtonVariant.neutral,
                                height: 48,
                                onPressed: () {
                                  setState(() {
                                    sort = PersonSortMode.asc;
                                    relation = null;
                                    tag = null;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ActionButton(
                                label: 'Terapkan',
                                height: 48,
                                showShadow: true,
                                onPressed: () {
                                  Navigator.of(ctx).pop(
                                    PersonFilterResult(
                                      sortMode: sort,
                                      relation: relation,
                                      tag: tag,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

          return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(ctx).maybePop(),
                  child: const SizedBox.expand(),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: content,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final baseBg = cs.surface;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: selected ? cs.primaryContainer : baseBg,
      selectedColor: cs.primaryContainer,
      side: BorderSide(color: selected ? cs.primary : cs.outlineVariant),
      labelStyle: TextStyle(
        color: selected ? cs.onPrimaryContainer : cs.onSurface,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      ),
      showCheckmark: false,
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({
    required this.children,
    this.scrollThreshold = 10,
    this.maxHeight = 180,
  });

  final List<Widget> children;
  final int scrollThreshold;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final wrap = Wrap(
      spacing: 12,
      runSpacing: 10,
      children: children,
    );
    final needsScroll = children.length > scrollThreshold;
    if (!needsScroll) {
      return wrap;
    }

    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: maxHeight,
          child: Scrollbar(
            thumbVisibility: true,
            radius: const Radius.circular(999),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(right: 8),
              physics: const BouncingScrollPhysics(),
              child: wrap,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Gulir untuk lihat lainnya',
          style: tt.bodySmall?.copyWith(
            color: cs.secondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tt.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: tt.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTagLabel(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return '';
  return trimmed.startsWith('#') ? trimmed : '#$trimmed';
}
