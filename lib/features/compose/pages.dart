import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/scaffold/form_scaffold.dart';
import 'routes.dart';
import 'pages/compose_page.dart';

final composePages = <GetPage>[
  GetPage(
    name: ComposeRoutes.page,
    page:
        () => FormScaffold(
          title: "Buat Jurnal",
          body: ComposePage(),
          action: ActionButton(
            label: "Unggah",
            onPressed: () {},
            height: 40,
            showShadow: true,
          ),
        ),
    transition: Transition.cupertino,
  ),
];
