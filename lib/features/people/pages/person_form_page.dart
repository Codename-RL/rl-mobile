import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/date_time_picker.dart';
import 'package:sapa_mobile/widgets/form/multi_value_textfield.dart';
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
  });

  final bool isEdit;
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialNickname;
  final String? initialAbout;
  final DateTime? initialBirthDate;
  final String? initialPhone;
  final String? initialEmail;

  @override
  State<PersonFormPage> createState() => _PersonFormPageState();
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

class _PersonFormPageState extends State<PersonFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _nicknameCtrl;
  late final TextEditingController _aboutCtrl;
  DateTime? _birthDate;
  late List<String> _phoneValues;
  late List<String> _emailValues;
  late List<String> _socialLinks;
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
    _phoneValues = _initialMultiValues(widget.initialPhone);
    _emailValues = _initialMultiValues(widget.initialEmail);
    _socialLinks = [''];
    _birthDate = widget.initialBirthDate;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _nicknameCtrl.dispose();
    _aboutCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }

  List<String> _initialMultiValues(String? raw) {
    if (raw == null || raw.trim().isEmpty) return [''];
    final values = raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    return values.isEmpty ? [''] : values;
  }

  List<String> _cleanValues(List<String> values) {
    return values.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
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
    final phones = _cleanValues(_phoneValues);
    final emails = _cleanValues(_emailValues);
    final socials = _cleanValues(_socialLinks);
    Get.back(result: {
      'firstName': _firstNameCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
      'nickname': _nicknameCtrl.text.trim(),
      'about': _aboutCtrl.text.trim(),
      'phone': phones.isEmpty ? '' : phones.first,
      'email': emails.isEmpty ? '' : emails.first,
      'phones': phones,
      'emails': emails,
      'socialLinks': socials,
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
        showShadow: true,
      ),
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 12),
            PhoneMultiField(
              values: _phoneValues,
              onChanged: (values) => _phoneValues = values,
            ),
            const SizedBox(height: 12),
            EmailMultiField(
              values: _emailValues,
              onChanged: (values) => _emailValues = values,
            ),
            const SizedBox(height: 12),
            MultiValueTextField(
              label: 'Link Sosial Media',
              variant: MultiFieldVariant.tagOrLink,
              initialValues: _socialLinks,
              hint: 'https://instagram.com/username',
              onChanged: (values) => _socialLinks = values,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
