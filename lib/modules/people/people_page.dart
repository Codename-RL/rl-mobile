import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      {'id': 'u1', 'name': 'Adi'},
      {'id': 'u2', 'name': 'Rifki'},
    ];

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final p = items[i];
        return ListTile(
          title: Text(p['name'] as String),
          onTap: () => Get.toNamed('/people/${p['id']}'), // <— ke detail
        );
      },
    );
  }
}
