// lib/modules/compose/location_search_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final TextEditingController _searchC = TextEditingController();
  String _query = '';

  // Dummy data dulu
  final List<_LocationItem> _allLocations = const [
    _LocationItem('Mataram', '3,7 km'),
    _LocationItem('Karang Pule, Sekarbela - Mataram', '0,3 km'),
    _LocationItem('Mataram, Lombok, Nusa Tenggara Barat', '2 km'),
    _LocationItem('Nusa Tenggara Barat', '3,7 km'),
    _LocationItem('Lombok, West Nusa Tenggara, Indonesia', '4 km'),
    _LocationItem('Kampus II UIN Mataram', '1,4 km · Jln. Gajah Mada'),
    _LocationItem('Sekarbela', '0,7 km'),
    _LocationItem('Pagesangan', '1,4 km'),
  ];

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final filtered = _allLocations.where((loc) {
      if (_query.isEmpty) return true;
      return loc.name.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return FormScaffold(
      title: 'Lokasi',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Pilih lokasi untuk ditandai',
            style: tt.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Orang yang Anda bagikan jurnal ini bisa melihat lokasi yang Anda tandai.',
            style: tt.bodySmall?.copyWith(
              color: cs.onSurface.withAlpha(160),
            ),
          ),
          const SizedBox(height: 12),

          // Search bar
          TextField(
            controller: _searchC,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded),
              hintText: 'Cari lokasi...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999),
                borderSide: BorderSide(
                  color: cs.outline.withAlpha(120),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(999),
                borderSide: BorderSide(
                  color: cs.primary,
                  width: 1.6,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // List lokasi
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final loc = filtered[index];
                return ListTile(
                  onTap: () => Get.back(result: loc.name),
                  title: Text(
                    loc.name,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurface),
                  ),
                  subtitle: loc.subtitle == null
                      ? null
                      : Text(
                          loc.subtitle!,
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurface.withAlpha(150),
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationItem {
  final String name;
  final String? subtitle;
  const _LocationItem(this.name, this.subtitle);
}
