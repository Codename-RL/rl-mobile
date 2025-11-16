// lib/widgets/form/journal_image_picker.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ComposeImagePicker extends StatefulWidget {
  const ComposeImagePicker({super.key});

  @override
  State<ComposeImagePicker> createState() => _ComposeImagePickerState();
}

class _ComposeImagePickerState extends State<ComposeImagePicker> {
  List<AssetEntity> _selectedAssets = [];

  Future<void> _pickImages() async {
    final result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: RequestType.image,
        maxAssets: 10,
        selectedAssets: _selectedAssets, // Preselect
      ),
    );

    if (result != null) {
      setState(() => _selectedAssets = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    const double thumbSize = 90;
    const double radius = 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================
        //      PREVIEW IMAGES
        // ==========================
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _selectedAssets.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  key: ValueKey(_selectedAssets.length),
                  height: thumbSize,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedAssets.length.clamp(0, 4),
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final asset = _selectedAssets[index];
                      final isLast =
                          index == 3 && _selectedAssets.length > 4; // overlay

                      return AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Thumbnail
                              AssetEntityImage(
                                asset,
                                fit: BoxFit.cover,
                              ),

                              // Overlay "+X"
                              if (isLast)
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        cs.primary.withAlpha(220),
                                        cs.secondary.withAlpha(220),
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    "+${_selectedAssets.length - 3}",
                                    style: tt.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),

        if (_selectedAssets.isNotEmpty) const SizedBox(height: 12),

        // ==========================
        //      BUTTON PILIH GAMBAR
        // ==========================
        SizedBox(
          height: 44,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: _pickImages,
            child: Ink(
              decoration: BoxDecoration(
                color: cs.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon/picture.svg',
                    width: 26,
                    height: 26,
                    colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Gambar',
                    style: tt.titleSmall?.copyWith(
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
