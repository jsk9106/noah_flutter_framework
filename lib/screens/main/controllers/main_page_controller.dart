import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/global_assets.dart';

class MainPageController extends GetxController {
  final List<Map<String, dynamic>> navList = [
    {
      'page': () => const SizedBox.shrink(),
      'label': '홈',
      'iconPath': GlobalAssets.svgLogo,
    },
    {
      'page': () => const SizedBox.shrink(),
      'label': '메뉴1',
      'iconPath': GlobalAssets.svgLogo,
    },
    {
      'page': () => const SizedBox.shrink(),
      'label': '메뉴2',
      'iconPath': GlobalAssets.svgLogo,
    },
    {
      'page': () => const SizedBox.shrink(),
      'label': '메뉴3',
      'iconPath': GlobalAssets.svgLogo,
    },
  ];

  int pageIndex = 0;
  Widget get page => navList[pageIndex]['page']();

  void onChangedPage(int index) {
    pageIndex = index;
    update();
  }
}
