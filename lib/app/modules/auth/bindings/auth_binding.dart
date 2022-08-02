import 'package:get/get.dart';
import 'package:vkhealth/app/modules/auth/controllers/auth_controller.dart';
import 'package:vkhealth/app/modules/auth/controllers/register_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
  
}