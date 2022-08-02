import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings redirect(String route) {
    final authService = Get.find<AuthService>();
    if (authService.isAuth) {
      try{
        if(DateTime.now().compareTo(DateTime.parse(authService.user.value.dateExpired)) < 0){
          return null;
        }
      } catch(e){
        return const RouteSettings(name: Routes.LOGIN);
      }
    }
    return const RouteSettings(name: Routes.LOGIN);
  }
}
