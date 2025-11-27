// lib/features/people/pages.dart
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/features/compose/pages/tag_picker_page.dart';
import 'package:sapa_mobile/widgets/button/circle_icon_button.dart';
import 'package:sapa_mobile/widgets/person/person_top_profile.dart';
import 'package:sapa_mobile/widgets/person/profile_options_sheet.dart';
import 'package:sapa_mobile/widgets/scaffold/profile_scaffold.dart';
import 'routes.dart';
import 'pages/people_page.dart';
import 'pages/person_detail_page.dart';
import 'pages/person_form_page.dart';

final peoplePages = <GetPage>[
  GetPage(
    name: PeopleRoutes.page,
    page:
        () =>
            const PeoplePage(), // jika mau bungkus MainScaffold di sini; atau langsung TabShell-content
    transition: Transition.noTransition,
  ),
  GetPage(
    name: PeopleRoutes.detail,
    transition: Transition.cupertino,
    page: () {
      final id = Get.parameters['id']!;
      final dummyName = 'Dwimas Nugraha';
      final dummyPhoto =
          'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg';
      final dummyTags = ['teman', 'godek', 'basong'];

      final hero = PersonTopProfile(
        name: dummyName,
        photoUrl: dummyPhoto,
        tags: dummyTags,
      );

      return ProfileScaffold(
        label: 'Teman',
        color: const Color(0xFF2E7D32),
        action: Builder(
          builder: (context) => CircleButton(
            iconAsset: 'assets/icon/three_dots.svg',
            variant: CircleBtnVariant.filled,
            size: 40,
            iconSize: 20,
            onTap: () => showProfileOptionsSheet(
              context,
              onEdit: () => Get.toNamed(
                PeopleRoutes.form,
                arguments: {
                  'isEdit': true,
                  'firstName': dummyName.split(' ').first,
                  'lastName': dummyName.split(' ').last,
                  'nickname': dummyName.split(' ').first,
                  'about':
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  'email': 'dwimas@example.com',
                  'phone': '+6281234567890',
                },
              ),
              onManageTags: () async {
                final result = await Get.to<List<String>>(
                  () => TagPickerPage(
                    initialSelected: dummyTags,
                  ),
                );
                if (result != null) {
                  Get.snackbar(
                    'Tag diperbarui',
                    result.join(', '),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ),
        ),
        hero: hero,
        heroHeight: PersonTopProfile.estimateHeight(dummyTags),
        padding: EdgeInsets.zero,
        body: PersonDetailPage(
          id: id,
          name: dummyName,
          photoUrl: dummyPhoto,
          tags: dummyTags,
        ),
        scrollable: false,
        // ⬇️ kalau di ProfileScaffold ada parameter heroHeight, isi ini:
        // heroHeight: PersonTopProfile.estimateHeight(dummyTags),
      );
    },
  ),
  GetPage(
    name: PeopleRoutes.form,
    transition: Transition.cupertino,
    page: () {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      return PersonFormPage(
        isEdit: args['isEdit'] == true,
        initialFirstName: args['firstName'] as String?,
        initialLastName: args['lastName'] as String?,
        initialNickname: args['nickname'] as String?,
        initialAbout: args['about'] as String?,
        initialEmail: args['email'] as String?,
        initialPhone: args['phone'] as String?,
        initialBirthDate: args['birthDate'] is DateTime
            ? args['birthDate'] as DateTime
            : (args['birthDate'] is String && (args['birthDate'] as String).isNotEmpty)
                ? DateTime.tryParse(args['birthDate'] as String)
                : null,
      );
    },
  ),
];
