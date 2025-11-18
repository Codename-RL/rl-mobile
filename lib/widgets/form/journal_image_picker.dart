// lib/widgets/form/journal_image_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ComposeImagePicker extends StatefulWidget {
  const ComposeImagePicker({
    super.key,
    this.showInternalButton = false, // default: cuma preview
  });

  /// Kalau true, tombol "Gambar" muncul di bawah preview.
  /// Di ComposePage nanti kita pakai false (button dari toolbar bawah).
  final bool showInternalButton;

  @override
  ComposeImagePickerState createState() => ComposeImagePickerState();
}

class ComposeImagePickerState extends State<ComposeImagePicker> {
  final List<AssetEntity> _selectedAssets = [];

  List<AssetEntity> get selectedAssets => List.unmodifiable(_selectedAssets);

  /// BISA DIPANGGIL DARI LUAR lewat GlobalKey
  Future<void> pickImages() async {
    final result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: RequestType.image,
        maxAssets: 10,
        selectedAssets: _selectedAssets,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedAssets
          ..clear()
          ..addAll(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    const thumbSize = 90.0;
    const radius = 18.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedAssets.isNotEmpty) ...[
          SizedBox(
            height: thumbSize,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedAssets.length.clamp(0, 4),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final asset = _selectedAssets[index];
                final showMoreOverlay =
                    _selectedAssets.length > 4 && index == 3;

                return SizedBox(
                  width: thumbSize,
                  height: thumbSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: showMoreOverlay
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              AssetEntityImage(
                                asset,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      cs.primary.withAlpha(230),
                                      cs.secondary.withAlpha(230),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  '+${_selectedAssets.length - 3}',
                                  style: tt.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : AssetEntityImage(
                            asset,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],

        if (widget.showInternalButton)
          SizedBox(
            height: 56,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: pickImages,
              child: Ink(
                decoration: BoxDecoration(
                  color: cs.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icon/picture.svg',
                      width: 26,
                      height: 26,
                      colorFilter:
                          ColorFilter.mode(cs.primary, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Gambar',
                      style: tt.titleMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
