// lib/features/people/pages.dart
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/circle_icon_button.dart';
import 'package:sapa_mobile/widgets/person/person_top_profile.dart';
import 'package:sapa_mobile/widgets/scaffold/profile_scaffold.dart';
import 'routes.dart';
import 'pages/people_page.dart';
import 'pages/person_detail_page.dart';

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
        action: CircleButton(
          iconAsset: 'assets/icon/three_dots.svg',
          variant: CircleBtnVariant.filled,
          size: 40,
          iconSize: 20,
          onTap: () {},
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
];
