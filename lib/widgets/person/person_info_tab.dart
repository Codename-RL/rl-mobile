// lib/widgets/person/person_info_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_mobile/widgets/post/journal_reminder.dart';

class PersonInfoTab extends StatelessWidget {
  const PersonInfoTab({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.about,
    required this.birthDate,
    this.importantDates = const [],
    this.phones = const [],
    this.emails = const [],
    this.socials = const [],
  });

  final String firstName;
  final String lastName;
  final String nickname;
  final String about;

  final String birthDate;
  final List<String> importantDates;

  final List<String> phones;
  final List<String> emails;
  final List<String> socials;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        // ====== KARTU IDENTITAS DASAR ======
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LabelValueText(label: 'Nama Depan', value: firstName),
              const SizedBox(height: 16),
              _LabelValueText(label: 'Nama Belakang', value: lastName),
              const SizedBox(height: 16),
              _LabelValueText(label: 'Panggilan', value: nickname),
              const SizedBox(height: 16),
              _LabelValueText(label: 'Tentang', value: about, multiLine: true),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ====== KARTU TANGGAL ======
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DateRow(
                label: 'Tanggal Lahir',
                value: birthDate,
                cs: cs,
                tt: tt,
              ),
              const SizedBox(height: 16),
              ...importantDates.asMap().entries.map(
                (e) => Padding(
                  padding: EdgeInsets.only(top: e.key == 0 ? 0 : 12),
                  child: _DateRow(
                    label: 'Tanggal Penting ${e.key + 1}',
                    value: e.value,
                    cs: cs,
                    tt: tt,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ====== KARTU KONTAK ======
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (phones.isNotEmpty) ...[
                Text(
                  'Nomor Telepon',
                  style: tt.labelMedium?.copyWith(
                    color: cs.primary.withAlpha(180),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...phones.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ContactField(
                      iconAsset: 'assets/icon/phone.svg', // sesuaikan asset
                      text: p,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (emails.isNotEmpty) ...[
                Text(
                  'Email',
                  style: tt.labelMedium?.copyWith(
                    color: cs.primary.withAlpha(180),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...emails.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ContactField(
                      iconAsset: 'assets/icon/mail.svg',
                      text: e,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              if (socials.isNotEmpty) ...[
                Text(
                  'Sosial Media',
                  style: tt.labelMedium?.copyWith(
                    color: cs.primary.withAlpha(180),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...socials.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ContactField(
                      iconAsset: _socialIconAsset(s),
                      text: s,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Card putih rounded untuk setiap section
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withAlpha(45),
            blurRadius: 5,
            spreadRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Label di atas + value di bawah
class _LabelValueText extends StatelessWidget {
  const _LabelValueText({
    required this.label,
    required this.value,
    this.multiLine = false,
  });

  final String label;
  final String value;
  final bool multiLine;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tt.labelSmall?.copyWith(
            color: cs.primary.withAlpha(140),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: tt.bodyMedium?.copyWith(
            color: cs.onSurface,
            height: multiLine ? 1.4 : 1.2,
          ),
        ),
      ],
    );
  }
}

/// Row tanggal + icon lonceng kanan
class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.label,
    required this.value,
    required this.cs,
    required this.tt,
  });

  final String label;
  final String value;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _LabelValueText(label: label, value: value)),
        const SizedBox(width: 12),
        JournalReminderIcon(),
      ],
    );
  }
}

/// Field kontak seperti input dengan icon kiri
class _ContactField extends StatelessWidget {
  const _ContactField({required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.primary.withAlpha(140), width: 1.5),
        color: cs.surface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 22,
            height: 22,
            // jika mau tint:
            // colorFilter: ColorFilter.mode(cs.onSurface, BlendMode.srcIn),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: tt.bodyMedium?.copyWith(color: cs.onSurface),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Pilih icon sosmed berdasarkan link/username
String _socialIconAsset(String urlOrUser) {
  final lower = urlOrUser.toLowerCase();
  if (lower.contains('instagram') || lower.contains('ig')) {
    return 'assets/icon/instagram.svg';
  }
  if (lower.contains('twitter') || lower.contains('x.com')) {
    return 'assets/icon/twitter.svg';
  }
  if (lower.contains('facebook') || lower.contains('fb.')) {
    return 'assets/icon/facebook.svg';
  }
  if (lower.contains('tiktok')) {
    return 'assets/icon/tiktok.svg';
  }
  // fallback generic link/user icon
  return 'assets/icon/link.svg';
}
