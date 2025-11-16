// lib/modules/compose/pages/compose_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_mobile/widgets/form/journal_image_picker.dart';
import 'package:sapa_mobile/widgets/form/location_picker_button.dart';
import 'package:sapa_mobile/widgets/post/compose_location_label.dart';

class ComposePage extends StatefulWidget {
  const ComposePage({super.key});

  @override
  State<ComposePage> createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  String? _locationName;
  final TextEditingController _contentC = TextEditingController();

  @override
  void dispose() {
    _contentC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================== PICK ORANG ==================
        // sementara dummy “Pilih orang” pakai container
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: cs.primary.withAlpha(80), width: 1.4),
          ),
          child: Row(
            children: [
              // avatar dummy
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 38,
                  height: 38,
                  color: cs.primary.withAlpha(80),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Dwimas',
                style: tt.titleMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ================== LOKASI YANG TERPILIH (DI SINI) ==================
        if (_locationName != null) ...[
          ComposeLocationLabel(
            text: _locationName!,
            onClear: () {
              setState(() => _locationName = null);
            },
          ),
          const SizedBox(height: 16),
        ] else
          const SizedBox(height: 12),

        // ================== TEXTAREA ==================
        TextField(
          controller: _contentC,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Apa yang anda pikirkan?',
            border: InputBorder.none,
            hintStyle: tt.titleMedium?.copyWith(
              color: cs.onSurface.withAlpha(80),
            ),
          ),
          style: tt.titleMedium?.copyWith(color: cs.onSurface),
        ),

        const SizedBox(height: 8),

        // ================== PREVIEW GAMBAR ==================
        const ComposeImagePicker(),

        const SizedBox(height: 12),

        // ================== BAR BAWAH: Gambar / Lokasi / Tag ==================
        Row(
          children: [
            // Tombol Gambar sudah di dalam ComposeImagePicker,
            // jadi di sini fokus ke Lokasi + Tag.
            Expanded(
              child: ComposeLocationPickerButton(
                onLocationSelected: (val) {
                  setState(() {
                    _locationName = val;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: _TagButton()),
          ],
        ),
      ],
    );
  }
}

/// contoh kecil tombol Tag biar baris bawah ada 3 item (gambar sudah di atas)
class _TagButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SizedBox(
      height: 56,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // TODO: buka picker tag
        },
        child: Ink(
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/tag.svg',
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: 10),
              Text(
                'Tag',
                style: tt.titleMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
