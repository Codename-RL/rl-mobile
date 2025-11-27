import 'package:flutter/material.dart';
import 'package:sapa_mobile/widgets/bg_bubbles.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';

class SettingProfileHeader extends StatelessWidget {
  const SettingProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,
    this.onEditProfile,
    this.height = 350,
  });

  final String name;
  final String email;
  final String? photoUrl;
  final VoidCallback? onEditProfile;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          const Positioned.fill(child: BgBubbles()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cs.surface, width: 0),
                      color: cs.surface,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withAlpha(60),
                      backgroundImage:
                          (photoUrl == null || photoUrl!.isEmpty)
                              ? null
                              : NetworkImage(photoUrl!),
                      child:
                          (photoUrl == null || photoUrl!.isEmpty)
                              ? Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: tt.headlineSmall?.copyWith(
                                  color: cs.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                              : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: tt.titleLarge?.copyWith(
                      color: cs.surface,
                      // fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: tt.titleMedium?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ActionButton(
                    label:  'Sunting Profil', 
                    onPressed: onEditProfile,
                    showShadow: true,
                  ),
                 
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
