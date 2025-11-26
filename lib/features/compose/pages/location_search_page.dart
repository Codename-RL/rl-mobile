// lib/modules/compose/location_search_page.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';
import 'package:sapa_mobile/widgets/form/search_bar.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final TextEditingController _searchC = TextEditingController();
  String _query = '';

  List<PlacePrediction> _predictions = [];
  bool _isLoading = false;
  Timer? _debounce;

  late final String _apiKey;

  @override
  void initState() {
    super.initState();
    _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'YOUR_GOOGLE_PLACES_KEY';
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchC.dispose();
    super.dispose();
  }

  void _onQueryChanged(String v) {
    setState(() => _query = v);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (_query.trim().isEmpty) {
        setState(() => _predictions = []);
        return;
      }
      _fetchPlaces(_query.trim());
    });
  }

  Future<void> _fetchPlaces(String input) async {
    setState(() => _isLoading = true);
    try {
      final uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        {
          'input': input,
          'key': _apiKey,
          'language': 'id',
          // Optional: batasi ke Indonesia
          // 'components': 'country:id',
          // Optional: tipe geocode/address
          // 'types': 'geocode',
        },
      );

      final resp = await http.get(uri);
      if (resp.statusCode != 200) {
        return;
      }

      final data = json.decode(resp.body) as Map<String, dynamic>;
      if (data['status'] != 'OK') {
        // bisa cek ZERO_RESULTS dsb kalau mau
        setState(() => _predictions = []);
        return;
      }

      final List preds = data['predictions'] as List;
      setState(() {
        _predictions =
            preds
                .map((e) => PlacePrediction.fromJson(e as Map<String, dynamic>))
                .toList();
      });
    } catch (e) {
      // TODO: bisa tampilkan snackbar/log
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return FormScaffold(
      title: 'Lokasi',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          

          AppSearchBar(
            controller: _searchC,
            hintText: 'Cari lokasi...',
            onChanged: _onQueryChanged,
            showFilter: false, // belum pakai filter di halaman ini
          ),
          // const SizedBox(height: 8),

          // List hasil Google Places
          Expanded(
            child:
                _isLoading && _predictions.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                      itemCount: _predictions.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final p = _predictions[index];
                        final mainText = p.mainText ?? p.description;
                        final secondaryText = p.secondaryText;

                        return ListTile(
                          onTap: () {
                            // Untuk sekarang kita kirim label string saja
                            Get.back(result: p.description);
                            // Kalau nanti mau simpan placeId juga,
                            // kamu bisa kirim objek kecil, bukan String.
                          },
                          title: Text(
                            mainText,
                            style: tt.bodyMedium?.copyWith(color: cs.onSurface),
                          ),
                          subtitle:
                              secondaryText == null
                                  ? null
                                  : Text(
                                    secondaryText,
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

/// Model prediction sederhana
class PlacePrediction {
  final String description;
  final String placeId;
  final String? mainText;
  final String? secondaryText;

  PlacePrediction({
    required this.description,
    required this.placeId,
    this.mainText,
    this.secondaryText,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    final sf = json['structured_formatting'] as Map<String, dynamic>?;
    return PlacePrediction(
      description: json['description'] as String? ?? '',
      placeId: json['place_id'] as String? ?? '',
      mainText: sf?['main_text'] as String?,
      secondaryText: sf?['secondary_text'] as String?,
    );
  }
}
