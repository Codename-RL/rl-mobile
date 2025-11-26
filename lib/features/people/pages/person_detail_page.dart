import 'package:flutter/material.dart';

class PersonDetailPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Detail Orang: $id',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // TODO: riwayat jurnal, statistik hubungan, dsb
      ],
    );
  }
}
