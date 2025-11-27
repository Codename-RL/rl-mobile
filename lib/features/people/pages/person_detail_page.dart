import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/button/square_icon_button.dart';
import 'package:sapa_mobile/widgets/person/person_detail_tab.dart';
import 'package:sapa_mobile/widgets/person/person_info_tab.dart';
import 'package:sapa_mobile/widgets/person/person_timeline_tab.dart';
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
        Row(
          children: [
            Expanded(
              child: Text(
                'Terbaru',
                style: tt.titleSmall?.copyWith(color: cs.primary),
              ),
            ),
            SquareIconButton(
              iconAsset: 'assets/icon/calendar.svg',
              tooltip: 'Lihat Kalender',
              onTap: () {},
            ),
            const SizedBox(width: 8),
            SquareIconButton(
              iconAsset: 'assets/icon/map.svg',
              tooltip: 'Lihat Peta',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
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
        return PersonInfoTab(
          firstName: 'Muhammad Dwimas',
          lastName: 'Catur Nugraha',
          nickname: 'Dwimas',
          about: 'Lorem Ipsum sdaun... (isi bio lengkap di sini)',
          birthDate: '17 Agustus 1945',
          importantDates: const ['17 Agustus 1945'],
          phones: const ['+628361274863284', '+628361274863284'],
          emails: const ['muhammaddwimas@gmail.com', 'dwimas.work@example.com'],
          socials: const [
            '@dimasngr_', // akan dianggap instagram
            'https://instagram.com/dimasngr_',
          ],
        );
      case 2:
        final timelineItems = [
          PersonTimelineItem(
            title: 'Membuat jurnal "Lore, Ipsum……"',
            createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          PersonTimelineItem(
            title: 'Memberi emosi ke jurnal "Lore……"',
            createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          ),
          PersonTimelineItem(
            title: 'Menambah email baru',
            createdAt: DateTime.now().subtract(const Duration(hours: 3)),
          ),
          PersonTimelineItem(
            title: 'Membuat jurnal "Lore, Ipsum……"',
            createdAt: DateTime(2025, 1, 12, 14, 30),
          ),
        ];

        return PersonTimelineTab(items: timelineItems);
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
        PersonDetailTabs(currentIndex: _currentTab, onChanged: _onTabChanged),
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
