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
  final TextEditingController _contentC = TextEditingController();
  final _imagePickerKey = GlobalKey<ComposeImagePickerState>();

  String? _locationName;

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
      children: [
        // ================== AREA ATAS (SCROLLABLE) ==================
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),

                // --- PILIH ORANG (dummy dulu) ---
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: cs.primary.withAlpha(15),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: cs.primary.withAlpha(80),
                      width: 1.4,
                    ),
                  ),
                  child: Row(
                    children: [
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

                // --- LABEL LOKASI DI BAWAH ORANG ---
                if (_locationName != null) ...[
                  ComposeLocationLabel(
                    text: _locationName!,
                    onClear: () => setState(() => _locationName = null),
                  ),
                  const SizedBox(height: 16),
                ] else
                  const SizedBox(height: 12),

                // --- TEXTAREA ---
                TextField(
                  controller: _contentC,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Apa yang anda pikirkan?',
                    hintStyle: tt.titleMedium?.copyWith(
                      color: cs.onSurface.withAlpha(80),
                    ),
                  ),
                  style: tt.titleMedium?.copyWith(color: cs.onSurface),
                ),

                const SizedBox(height: 8),

                // --- PREVIEW GAMBAR ---
                ComposeImagePicker(
                  key: _imagePickerKey,
                  showInternalButton: false, // tombolnya pakai toolbar bawah
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        // ================== TOOLBAR BAWAH (STICKY + SAFEAREA) ==================
        SafeArea(
          top: false,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: _ToolButton(
                    iconAsset: 'assets/icon/picture.svg',
                    label: 'Gambar',
                    onTap: () {
                      _imagePickerKey.currentState?.pickImages();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ComposeLocationPickerButton(
                    onLocationSelected: (val) {
                      setState(() => _locationName = val);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ToolButton(
                    iconAsset: 'assets/icon/tag.svg',
                    label: 'Tag',
                    onTap: () {
                      // TODO: buka picker tag
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.iconAsset,
    required this.label,
    this.onTap,
  });

  final String iconAsset;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SizedBox(
      height: 44,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconAsset,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: tt.titleSmall?.copyWith(
                  color: cs.primary,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
