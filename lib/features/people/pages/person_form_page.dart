import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/date_time_picker.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../../../widgets/person/profile_photo_picker.dart';

class PersonFormPage extends StatefulWidget {
  const PersonFormPage({
    super.key,
    this.isEdit = false,
    this.initialFirstName,
    this.initialLastName,
    this.initialNickname,
    this.initialAbout,
    this.initialBirthDate,
    this.initialPhone,
    this.initialEmail,
    this.initialTags,
  });

  final bool isEdit;
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialNickname;
  final String? initialAbout;
  final DateTime? initialBirthDate;
  final String? initialPhone;
  final String? initialEmail;
  final String? initialTags;

  @override
  State<PersonFormPage> createState() => _PersonFormPageState();
}

class _PersonFormPageState extends State<PersonFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _nicknameCtrl;
  late final TextEditingController _aboutCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _tagsCtrl;
  DateTime? _birthDate;
  Uint8List? _profileImageBytes;
  AssetEntity? _selectedAvatarAsset;
  String? _profileImagePath;
  bool _isPickingAvatar = false;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController(text: widget.initialFirstName ?? '');
    _lastNameCtrl = TextEditingController(text: widget.initialLastName ?? '');
    _nicknameCtrl = TextEditingController(text: widget.initialNickname ?? '');
    _aboutCtrl = TextEditingController(text: widget.initialAbout ?? '');
    _phoneCtrl = TextEditingController(text: widget.initialPhone ?? '');
    _emailCtrl = TextEditingController(text: widget.initialEmail ?? '');
    _tagsCtrl = TextEditingController(text: widget.initialTags ?? '');
    _birthDate = widget.initialBirthDate;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _nicknameCtrl.dispose();
    _aboutCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 1),
      locale: const Locale('id', 'ID'),
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_firstNameCtrl.text.trim().isEmpty) {
      Get.snackbar(
        'Form belum lengkap',
        'Nama depan wajib diisi',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    Get.back(result: {
      'firstName': _firstNameCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
      'nickname': _nicknameCtrl.text.trim(),
      'about': _aboutCtrl.text.trim(),
      'phone': _phoneCtrl.text.trim(),
      'email': _emailCtrl.text.trim(),
      'tags': _tagsCtrl.text.trim(),
      'birthDate': _birthDate?.toIso8601String(),
      'photoPath': _profileImagePath,
    });
  }

  Future<void> _pickProfilePhoto() async {
    if (_isPickingAvatar) return;
    final theme = Theme.of(context);
    setState(() => _isPickingAvatar = true);
    try {
      final result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: RequestType.image,
          maxAssets: 1,
          selectedAssets:
              _selectedAvatarAsset == null ? null : [_selectedAvatarAsset!],
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
          IOSUiSettings(
            title: 'Sesuaikan Foto',
            aspectRatioLockEnabled: true,
          ),
        ],
      );
      if (cropped == null) return;

      final bytes = await cropped.readAsBytes();
      if (!mounted) return;
      setState(() {
        _selectedAvatarAsset = asset;
        _profileImageBytes = bytes;
        _profileImagePath = cropped.path;
      });
    } finally {
      if (mounted) {
        setState(() => _isPickingAvatar = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      title: widget.isEdit ? 'Sunting Profil' : 'Tambah Orang',
      action: ActionButton(
        label: widget.isEdit ? 'Simpan' : 'Tambah',
        onPressed: _submit,
        height: 40,
        radius: 20,
        showShadow: true,
      ),
      scrollable: true,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ProfilePhotoPicker(
                imageBytes: _profileImageBytes,
                isLoading: _isPickingAvatar,
                onTap: _pickProfilePhoto,
              ),
            ),
            const SizedBox(height: 24),
            _SectionLabel(title: 'Informasi Dasar'),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Nama Depan',
              controller: _firstNameCtrl,
              type: AppTextFieldType.text,
              textInputAction: TextInputAction.next,
              hintText: 'Masukkan nama depan',
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Nama Belakang',
              controller: _lastNameCtrl,
              type: AppTextFieldType.text,
              isRequired: false,
              hintText: 'Masukkan nama belakang',
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Nama Panggilan',
              controller: _nicknameCtrl,
              type: AppTextFieldType.text,
              isRequired: false,
              hintText: 'Masukkan nama panggilan',
            ),
            const SizedBox(height: 12),
            AppTextArea(
              label: 'Tentang',
              controller: _aboutCtrl,
              hintText: 'Ceritakan sedikit tentang orang ini',
              minLines: 4,
              maxLines: 6,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _pickBirthDate,
              child: AbsorbPointer(
                child: DateTimePicker(
                  label: 'Tanggal Lahir',
                  placeholder: _birthDate == null
                      ? 'Pilih tanggal'
                      : _formatDate(_birthDate!),
                  allowTime: false,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _SectionLabel(title: 'Kontak'),
            const SizedBox(height: 12),
            _buildField(
              label: 'Nomor Telepon',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildField(
              label: 'Email',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            _SectionLabel(title: 'Detail Lain'),
            const SizedBox(height: 12),
            _buildField(
              label: 'Tag (pisahkan dengan koma)',
              controller: _tagsCtrl,
              hintText: 'teman, kantor, keluarga',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    final cs = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: cs.surfaceContainerHighest.withAlpha(30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
