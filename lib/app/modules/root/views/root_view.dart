import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/root/controllers/root_controller.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../global_widgets/custom_bottom_nav_bar.dart';

class RootView extends GetView<RootController> {
  const RootView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx((){
      return Scaffold(
        body: controller.currentPage,
        bottomNavigationBar: CustomBottomNavigationBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          itemColor: context.theme.colorScheme.secondary,
          currentIndex: controller.currentIndex.value,
          onChange: (index) {
            controller.changePage(index);
          },
          children: [
            CustomBottomNavigationItem(
              icon: Icons.home_outlined,
              label: "Trang chủ".tr,
              color: Colors.black,
            ),
            CustomBottomNavigationItem(
                icon: Icons.notifications_sharp,
                label: "Thông báo".tr,
                color: Colors.black
            ),
            CustomBottomNavigationItem(
                icon: Icons.search,
                label: "Tìm kiếm".tr,
                color: Colors.black
            ),
            CustomBottomNavigationItem(
                icon: Icons.person,
                label: "Tài khoản".tr,
                color: Colors.black
            ),
          ],
        ),
      );
    });
  }

}