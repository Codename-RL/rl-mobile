// lib/widgets/form/compose_location_picker_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/features/compose/pages/location_search_page.dart';


class ComposeLocationPickerButton extends StatelessWidget {
  const ComposeLocationPickerButton({
    super.key,
    required this.onLocationSelected,
  });

  final ValueChanged<String?> onLocationSelected;

  Future<void> _openLocationSearch() async {
    final result = await Get.to<String>(() => const LocationSearchPage());
    // result bisa null kalau user back
    onLocationSelected(result);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SizedBox(
      height: 44,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _openLocationSearch,
        child: Ink(
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/map_button.svg',
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Text(
                'Lokasi',
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
