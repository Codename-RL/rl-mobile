import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/person/empty_people_card.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: ganti dengan data asli dari controller / API
    final items = const <Map<String, String>>[
      // kalau mau tes empty state, ubah jadi: const <Map<String,String>>[]
      // {'id': 'u1', 'name': 'Adi'},
      // {'id': 'u2', 'name': 'Rifki'},
    ];

    if (items.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            EmptyPeopleCard(
              onAddTap: () {
                // arahkan ke halaman tambah orang
                // misal:
                Get.toNamed('/people/create');
              },
            ),
          ],
        ),
      );
    }

    // kalau sudah ada orang → list biasa
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final p = items[i];
        return ListTile(
          title: Text(p['name'] as String),
          onTap: () => Get.toNamed('/people/${p['id']}'),
        );
      },
    );
  }
}
