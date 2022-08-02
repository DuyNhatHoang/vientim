
// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/auth/controllers/auth_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/text_field_widget.dart';

import '../../global_widgets/buttons/block_button_widget.dart';

class ForgetPassView extends GetView<AuthController> {
  const ForgetPassView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = GlobalKey<FormState>();  
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx((){return Form(
        key: controller.forgotPasswordFormKey,
        child: ListView(
          primary: true,
          children: [
            const SizedBox(height: 20,),
            Image.asset("assets/icon/vientiem.png", height: 150,),
            const SizedBox(height: 20,),
            Center(
              child: Text("Quên Mật Khẩu".tr, style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),),
            ), const SizedBox(height: 20,),
            TextFieldWidget(
              labelText: "Số điện thoại".tr,
              iconData: Icons.phone,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17
              ),
              onSaved: (input) =>  controller.phoneNumber.value = input,
              validator: (input) =>
              input.length < 10
                  ? "Số điện thoại không hợp lệ".tr
                  : null,
            ).marginSymmetric(horizontal: 10),
            TextFieldWidget(
              labelText: "Mật khẩu mới".tr,
              hintText: "••••••••••••",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17
              ),
              onSaved: (input) =>
              controller.newPass.value = input,
              validator: (input) =>
              input.length < 6
                  ? "Mật khẩu lớn hơn 6 kí tự"
                  : null,
              obscureText: controller.fhidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.fhidePassword.value =
                  !controller.fhidePassword.value;
                },
                color: Theme
                    .of(context)
                    .focusColor,
                icon: Icon(controller.fhidePassword.value ? Icons
                    .visibility_outlined : Icons
                    .visibility_off_outlined),
              ),
            ).marginSymmetric(horizontal: 10),
            TextFieldWidget(
              labelText: "Xác nhận mật khẩu mới".tr,
              hintText: "••••••••••••",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17
              ),
              validator: (input) =>
              input != controller.newPass.value
                  ? "Xác nhận mật khẩu không đúng"
                  : null,
              obscureText: controller.fchidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.fchidePassword.value =
                  !controller.fchidePassword.value;
                },
                color: Theme
                    .of(context)
                    .focusColor,
                icon: Icon(controller.fchidePassword.value ? Icons
                    .visibility_outlined : Icons
                    .visibility_off_outlined),
              ),
            ).marginSymmetric(horizontal: 10),
            BlockButtonWidget(
              onPressed: () {
                controller.generateOTP(context);
              },
              color: Get.theme.colorScheme.secondary,
              text: Text(
                "Xác nhận",
                style: Get.textTheme.headline6.merge(
                    TextStyle(color: Get.theme.primaryColor)),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ],
        ),
      );}),
    );
  }

}

