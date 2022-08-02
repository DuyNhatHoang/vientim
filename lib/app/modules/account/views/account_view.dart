import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/routes/app_routes.dart';

import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../../../common/ui.dart';
import '../../global_widgets/buttons/logout_widget.dart';
import '../../global_widgets/user_avatar.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController>{
  const AccountView({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    controller.getProfile(context);
    controller.getUserInfo(context);
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        body: ListView(
          primary: true,
          children: [
            const SizedBox(height: 30,),
            Obx(
                (){
                  if(controller.profile.value.gender == null || controller.userInfo.value.data == null) return Container();
                  if(controller.profile.value.phoneNumber != null && controller.userInfo.value.data.userInfo.fullName != null){
                    return UserAvatarVer(phone:  controller.userInfo.value.data.userInfo.phoneNumber,
                      name: controller.profile.value.fullname == controller.profile.value.username ? controller.userInfo.value.data.userInfo.fullName:controller.profile.value.fullname, showDetail: true,);
                  }
                  return Container();
                }
            ),
            horiFunc("assets/icon/user_with_bg.png", "Thông tin cá nhân", ontap: () async {
              if(controller.profile.value.fullname == null){
                Get.showSnackbar(Ui.RemindSnackBar(message: "Lấy thông tin thất bại"));
              } else {
                Get.toNamed(Routes.USER_INFOR, arguments: controller.provinces);
              }
            }),
            horiFunc("assets/icon/lock_with_bg.png", "Cài đặt mật khẩu", ontap: (){
              Get.toNamed(Routes.PASSWORD_SETTING);
            } ),
            LogOutWidget(
              onTap: (){
                controller.logout();
              },
            )
          ],
        ),
      ),
    );

  }

  Widget horiFunc(String icon, String title, {Function ontap}){
    return InkWell(
      onTap: ontap,
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 6 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: SizeConfig.screenWidth * 0.01, ),
                Image.asset(icon, height: SizeConfig.screenWidth * 0.11, width: SizeConfig.screenWidth * 0.09 ),
                SizedBox(width: SizeConfig.screenWidth * 0.04, ),
                Text(title, style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth * 0.045, fontWeight: FontWeight.w500),),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,size: SizeConfig.screenWidth * 0.04, color: Colors.black.withOpacity(0.7),)
          ],
        ),
      ),
    );
  }

}