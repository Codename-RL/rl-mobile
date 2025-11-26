import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/features/compose/pages/person_search_page.dart';


import 'person_list_tile.dart';

class ComposePersonPickerButton extends StatelessWidget {
  const ComposePersonPickerButton({
    super.key,
    this.selectedPerson,
    this.onPersonSelected,
  });

  final PersonOption? selectedPerson;
  final ValueChanged<PersonOption>? onPersonSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SizedBox(
      height: 46,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          final result = await Get.to<PersonOption?>(
            () => const PersonSearchPage(),
          );
          if (result != null) {
            onPersonSelected?.call(result);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: cs.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: cs.primary.withAlpha(80),
              width: 1.4,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: selectedPerson == null
                    ? SvgPicture.asset(
                        'assets/icon/person.svg', // svg user
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          cs.primary,
                          BlendMode.srcIn,
                        ),
                      )
                    : Image.network(
                        selectedPerson!.avatarUrl,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 12),
              Text(
                selectedPerson?.name ?? 'Pilih orang',
                style: tt.titleSmall?.copyWith(
                  color: selectedPerson == null
                      ? cs.onSurface.withAlpha(120)
                      : cs.primary,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
