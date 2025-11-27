import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/features/setting/routes.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';
import 'package:sapa_mobile/widgets/setting/setting_profile_header.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const double _heroHeight = 350;

  @override
  Widget build(BuildContext context) {
    const userName = 'Dwimas Nugraha';
    const userEmail = 'dwimas@example.com';
    const photoUrl =
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg';

    final cs = Theme.of(context).colorScheme;
    return FormScaffold(
      title: 'Pengaturan',
      titleColor: cs.surface,
      scrollable: true,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      hero: SettingProfileHeader(
        name: userName,
        email: userEmail,
        photoUrl: photoUrl,
        height: _heroHeight,
        onEditProfile:
            () => Get.toNamed(
              SettingRoutes.editProfile,
              arguments: {'name': userName, 'email': userEmail},
            ),
      ),
      heroHeight: _heroHeight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          _SettingMenuButton(
            label: 'Ganti Kata Sandi',
            iconAsset: 'assets/icon/secure.svg',
            onTap: () => Get.toNamed(SettingRoutes.changePassword),
          ),
          const SizedBox(height: 12),
          _SettingMenuButton(
            label: 'Keluar',
            iconAsset: 'assets/icon/logout2.svg',
            variant: _SettingMenuVariant.danger,
            onTap: () {
              // TODO: tambahkan aksi logout.
            },
          ),
        ],
      ),
    );
  }
}

enum _SettingMenuVariant { normal, danger }

class _SettingMenuButton extends StatelessWidget {
  const _SettingMenuButton({
    required this.label,
    required this.iconAsset,
    this.onTap,
    this.variant = _SettingMenuVariant.normal,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onTap;
  final _SettingMenuVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    final bool isDanger = variant == _SettingMenuVariant.danger;
    final Color baseText = isDanger ? cs.error : cs.secondary;
    final Color iconColor = isDanger ? cs.error : cs.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: tt.titleMedium?.copyWith(color: baseText),
              ),
            ),
            if (!isDanger)
              SvgPicture.asset(
                'assets/icon/arrow_right.svg',
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  cs.primary.withAlpha(100),
                  BlendMode.srcIn,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
