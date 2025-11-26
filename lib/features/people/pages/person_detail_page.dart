import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/person/person_detail_tab.dart';

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

  Widget _buildTabContent(ThemeData theme) {
    final tt = theme.textTheme;
    switch (_currentTab) {
      case 0:
        return Text(
          'Belum ada jurnal untuk ${widget.name}.',
          style: tt.bodyLarge,
        );
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        

        PersonDetailTabs(
          currentIndex: _currentTab,
          onChanged: _onTabChanged,
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildTabContent(theme),
        ),
      ],
    );
  }
}
