import 'package:get/get.dart';
import 'package:vkhealth/app/modules/home/controllers/home_controller.dart';
import 'package:vkhealth/app/modules/root/controllers/root_controller.dart';
import 'package:vkhealth/app/modules/search/controllers/search_controller.dart';

import '../../share/controllers/share_controller.dart';

class RootBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
    Get.put(HomeController(), permanent: true);
    Get.put(ShareController(), permanent: true);
    Get.put(SearchController(), permanent: true);
    Get.put(ShareController(), permanent: true);
  }
}