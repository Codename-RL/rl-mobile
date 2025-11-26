import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/person/person_detail_tab.dart';
import 'package:sapa_mobile/widgets/post/post_card.dart';

class PersonDetailPage extends StatefulWidget {
  const PersonDetailPage({
    super.key,
    required this.id,
    required this.name,
    this.photoUrl,
    this.tags = const [],
  });
  final String id;
  final String name;
  final String? photoUrl;
  final List<String> tags;

  @override
  State<PersonDetailPage> createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  int _currentTab = 0;

  void _onTabChanged(int idx) {
    if (_currentTab == idx) return;
    setState(() => _currentTab = idx);
  }

  List<PostCard> _buildDummyPosts() {
    return [
      PostCard(
        fullName: widget.name,
        photoUrl: widget.photoUrl ?? 'https://picsum.photos/200',
        relationText: 'Teman',
        relationColor: Colors.green,
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
        content:
            'Lorem ipsum asndajn dasndasndasm dnasmdn a asndajlsdajsdnadjsdnasd asdna jsdnjasn djandaw jdnasjdn adnasjndasjn dadnasjdn askj',
        tags: const ['sukil', 'muncak', 'liburan', 'jalanjalan', 'alam'],
      ),
      PostCard(
        fullName: widget.name,
        photoUrl: widget.photoUrl ?? 'https://picsum.photos/201',
        relationText: 'Teman',
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
        locationText: 'Universitas Mataram',
        content:
            'Lorem ipsum asndajn dasndasndasm dnasmdn a asndajlsdajsdnadjsdnasd asdna jsdnjasn djandaw jdnasjdn adnasjndasjn dadnasjdn askj',
      ),
      PostCard(
        fullName: widget.name,
        photoUrl: widget.photoUrl ?? 'https://picsum.photos/202',
        relationText: 'Teman',
        createdAt: DateTime.now().subtract(const Duration(minutes: 4)),
        locationText: 'Universitas Mataram',
        tags: const ['sukil', 'muncak', 'liburan', 'jalanjalan', 'alam'],
        content:
            'Lorem ipsum asndajn dasndasndasm dnasmdn a asndajlsdajsdnadjsdnasd asdna jsdnjasn djandaw jdnasjdn adnasjndasjn dadnasjdn askj',
        images: const [
          'https://picsum.photos/800/800?1',
          'https://picsum.photos/800/800?2',
          'https://picsum.photos/800/800?3',
        ],
      ),
    ];
  }

  Widget _buildJournalTab(ThemeData theme) {
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    final posts = _buildDummyPosts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Terbaru', style: tt.titleSmall?.copyWith(color: cs.primary)),
        const SizedBox(height: 6),
        for (var i = 0; i < posts.length; i++) ...[
          posts[i],
          if (i != posts.length - 1) const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildTabContent(ThemeData theme) {
    final tt = theme.textTheme;
    switch (_currentTab) {
      case 0:
        return _buildJournalTab(theme);
      case 1:
        return Text(
          'Informasi dasar ${widget.name} (ID: ${widget.id}).',
          style: tt.bodyLarge,
        );
      case 2:
        return Text(
          'Linimasa interaksi akan ditampilkan di sini.',
          style: tt.bodyLarge,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PersonDetailTabs(
          currentIndex: _currentTab,
          onChanged: _onTabChanged,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: _buildTabContent(theme),
            ),
          ),
        ),
      ],
    );
  }
}
