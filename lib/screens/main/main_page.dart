import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../util/components/base_widget.dart';
import 'controllers/main_page_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainPageController controller = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: GetBuilder<MainPageController>(
        builder: (_) {
          return Scaffold(
            body: controller.page,
            bottomNavigationBar: bottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 56 * sizeUnit,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1 * sizeUnit,
            color: $style.colors.lightGrey,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: controller.pageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedLabelStyle: $style.text.subTitle12,
        unselectedLabelStyle: $style.text.body12,
        selectedItemColor: $style.colors.primary,
        unselectedItemColor: $style.colors.black,
        elevation: 0,
        onTap: controller.onChangedPage,
        items: List.generate(
          controller.navList.length,
          (index) {
            final Map<String, dynamic> navItem = controller.navList[index];

            return BottomNavigationBarItem(
              label: navItem['label'],
              icon: SvgPicture.asset(
                navItem['iconPath'],
                width: 24 * sizeUnit,
                colorFilter: ColorFilter.mode(
                  $style.colors.black,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                navItem['iconPath'],
                width: 24 * sizeUnit,
                colorFilter: ColorFilter.mode(
                  $style.colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
