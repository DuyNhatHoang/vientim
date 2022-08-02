import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/home/controllers/home_controller.dart';
import 'package:vkhealth/app/modules/home/views/home_view.dart';
import 'package:vkhealth/app/modules/notification/views/notification_view.dart';

import '../../../routes/app_routes.dart';
import '../../account/controllers/account_controller.dart';
import '../../account/views/account_view.dart';
import '../../search/views/search_view.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;

  // NotificationRepository _notificationRepository;

  RootController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    inputPageController();
    if (Get.arguments != null && Get.arguments is int) {
      changePageInRoot(Get.arguments as int);
    } else {
      changePageInRoot(0);
    }
    super.onInit();
  }

  List<Widget> pages = [
    const HomeView(),
    const NotificationView(),
    const SearchView(),
    const AccountView()
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePageInRoot(int _index) {
    currentIndex.value = _index;
  }

  void inputPageController(){
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<HomeController>(() => HomeController());
  }

  void changePageOutRoot(int _index) {
    currentIndex.value = _index;
    Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  Future<void> changePage(int _index) async {
    if (Get.currentRoute == Routes.ROOT) {
      changePageInRoot(_index);
    } else {
      changePageOutRoot(_index);
    }
    await refreshPage(_index);
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        {
          // await Get.find<HomeController>().refreshHome();
          break;
        }
      case 2:
        {
          // await Get.find<MessagesController>().refreshMessages();
          break;
        }
    }
  }
}
