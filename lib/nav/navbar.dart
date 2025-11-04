import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'nav_controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});


  static const _iconSize = 32.0;     // ukuran ikon SVG normal
  static const _composeSize = 54.0;  // ukuran ikon SVG untuk compose
  static const _itemBox = 36.0;      // kotak normal
  static const _bubbleBox = 58.0;    // kotak compose/bubble

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final c = Get.find<NavController>();

    Widget navItem({
      required int i,
      required String asset,
      required String assetFilled,
      bool bubble = false,
    }) {
      return Obx(() {
        final active = c.index.value == i;
        final file = active ? assetFilled : asset;

        // jika bubble = true → gunakan ukuran compose
        final svg = SvgPicture.asset(
          file,
          width: bubble ? _composeSize : _iconSize,
          height: bubble ? _composeSize : _iconSize,
          // colorFilter: ColorFilter.mode(
          //   active ? cs.onPrimary : cs.onSurface,
          //   BlendMode.srcIn,
          // ),
        );

        final boxSide = bubble ? _bubbleBox : _itemBox;

       final child = active && bubble
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(child: svg),
              )
            : Center(child: svg);

        return InkWell(
          borderRadius: BorderRadius.circular(boxSide / 2),
          onTap: () => c.go(i),
          child: SizedBox.square(
            dimension: boxSide,
            child: child,
          ),
        );
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      decoration: BoxDecoration(
        color: Color.alphaBlend(Colors.black.withAlpha(40), cs.primary.withAlpha(50)),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withAlpha(30), width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navItem(
            i: 0,
            asset: 'assets/icon/nav/stroke_journal.svg',
            assetFilled: 'assets/icon/nav/fill_journal.svg',
          ),
          navItem(
            i: 1,
            asset: 'assets/icon/nav/stroke_people.svg',
            assetFilled: 'assets/icon/nav/fill_people.svg',
          ),
          navItem(
            i: 2,
            asset: 'assets/icon/nav/compose.svg',
            assetFilled: 'assets/icon/nav/compose.svg',
            bubble: true,
          ),
          navItem(
            i: 3,
            asset: 'assets/icon/nav/stroke_reminder.svg',
            assetFilled: 'assets/icon/nav/fill_reminder.svg',
          ),
          navItem(
            i: 4,
            asset: 'assets/icon/nav/stroke_setting.svg',
            assetFilled: 'assets/icon/nav/fill_setting.svg',
          ),
        ],
      ),
    );
  }
}


