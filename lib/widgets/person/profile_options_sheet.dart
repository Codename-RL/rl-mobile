import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Helper to show profile options bottom sheet
Future<void> showProfileOptionsSheet(
  BuildContext context, {
  VoidCallback? onEdit,
  VoidCallback? onArchive,
  VoidCallback? onDelete,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(sheetContext).maybePop(),
            child: const SizedBox.expand(),
          ),
        ),
        ProfileOptionsSheet(
          onEdit: onEdit,
          onArchive: onArchive,
          onDelete: onDelete,
        ),
      ],
    ),
  );
}

class ProfileOptionsSheet extends StatelessWidget {
  const ProfileOptionsSheet({
    super.key,
    this.onEdit,
    this.onArchive,
    this.onDelete,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 6,
                    decoration: BoxDecoration(
                      color: cs.outlineVariant.withAlpha(160),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 20),
                  EditProfileOption(
                    onTap: () {
                      Navigator.of(context).pop();
                      onEdit?.call();
                    },
                  ),
                  const SizedBox(height: 12),
                  ArchiveProfileOption(
                    onTap: () {
                      Navigator.of(context).pop();
                      onArchive?.call();
                    },
                  ),
                  const SizedBox(height: 12),
                  DeleteProfileOption(
                    onTap: () {
                      Navigator.of(context).pop();
                      onDelete?.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileOption extends StatelessWidget {
  const EditProfileOption({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _ProfileOptionTile(
      iconAsset: 'assets/icon/pen.svg',
      label: 'Sunting Profil',
      color: cs.primary,
      onTap: onTap,
    );
  }
}

class ArchiveProfileOption extends StatelessWidget {
  const ArchiveProfileOption({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _ProfileOptionTile(
      iconAsset: 'assets/icon/archive.svg',
      label: 'Arsipkan Profil',
      color: cs.primary,
      onTap: onTap,
    );
  }
}

class DeleteProfileOption extends StatelessWidget {
  const DeleteProfileOption({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _ProfileOptionTile(
      iconAsset: 'assets/icon/trash.svg',
      label: 'Hapus Profil',
      color: cs.error,
      onTap: onTap,
    );
  }
}

class _ProfileOptionTile extends StatelessWidget {
  const _ProfileOptionTile({
    required this.iconAsset,
    required this.label,
    required this.color,
    this.onTap,
  });

  final String iconAsset;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconAsset,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
