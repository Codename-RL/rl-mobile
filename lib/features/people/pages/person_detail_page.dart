import 'package:flutter/material.dart';

class PersonDetailPage extends StatelessWidget {
  const PersonDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    // TODO: fetch data orang by id
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Text('Detail Orang: $id',
            style: Theme.of(context).textTheme.titleLarge),
        // … field lain
      ],
    );
  }
}
