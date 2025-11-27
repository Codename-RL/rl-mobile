import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin ProfilePhotoPickerMixin<T extends StatefulWidget> on State<T> {
  Uint8List? profileImageBytes;
  AssetEntity? selectedAvatarAsset;
  String? profileImagePath;
  bool isPickingAvatar = false;

  Future<void> pickProfilePhoto() async {
    if (isPickingAvatar) return;
    final theme = Theme.of(context);
    setState(() => isPickingAvatar = true);
    try {
      final result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: RequestType.image,
          maxAssets: 1,
          selectedAssets:
              selectedAvatarAsset == null ? null : [selectedAvatarAsset!],
        ),
      );
      if (result == null || result.isEmpty) return;

      final asset = result.first;
      final file = await asset.file;
      if (file == null) return;

      final cropped = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Sesuaikan Foto',
            toolbarWidgetColor: theme.colorScheme.onSurface,
            toolbarColor: theme.colorScheme.surface,
            activeControlsWidgetColor: theme.colorScheme.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'Sesuaikan Foto', aspectRatioLockEnabled: true),
        ],
      );
      if (cropped == null) return;

      final bytes = await cropped.readAsBytes();
      if (!mounted) return;
      setState(() {
        selectedAvatarAsset = asset;
        profileImageBytes = bytes;
        profileImagePath = cropped.path;
      });
    } finally {
      if (mounted) {
        setState(() => isPickingAvatar = false);
      }
    }
  }
}
