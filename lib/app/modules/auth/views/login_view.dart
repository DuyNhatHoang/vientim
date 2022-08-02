
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/auth/controllers/auth_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/text_field_widget.dart';
import 'package:vkhealth/app/routes/app_routes.dart';
import 'package:vkhealth/common/helper.dart';

import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: controller.loginFormKey,
          child: ListView(
            primary: true,
            children: [
              Image.asset("assets/icon/vientiem.png", height: 150,),
              const SizedBox(height: 20,),
              Center(
                child: Text("Đăng nhập".tr, style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
              ),
              Obx(() {
                if (controller.loading.isTrue) {
                  return const CircularLoadingWidget(height: 300);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        labelText: "Số điện thoại".tr,
                        hintText: "0946******",
                        initialValue: controller.loginRequest?.value?.username,
                        onSaved: (input) =>
                        controller.loginRequest.value.username = input,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17
                        ),
                        validator: (input) =>
                        input.isEmpty
                            ? "Số điện thoại không hợp lệ".tr
                            : null,
                        iconData: Icons.phone,
                      ).marginSymmetric(horizontal: 10, vertical: 10),
                      Obx(() {
                        return TextFieldWidget(
                          labelText: "Mật khẩu".tr,
                          hintText: "••••••••••••",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17
                          ),
                          initialValue: controller.loginRequest?.value?.password,
                          onSaved: (input) =>
                          controller.loginRequest.value.password = input,
                          validator: (input) =>
                          input.length < 3
                              ? "Mật khẩu lớn hơn 6 kí tự"
                              : null,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                              !controller.hidePassword.value;
                            },
                            color: Theme
                                .of(context)
                                .focusColor,
                            icon: Icon(controller.hidePassword.value ? Icons
                                .visibility_outlined : Icons
                                .visibility_off_outlined),
                          ),
                        ).marginSymmetric(horizontal: 10);
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: Checkbox(value: true, onChanged: (s) {}),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text("Nhớ mật khẩu", style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w700),),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.FORGET_PASS);
                            },
                            child: const Text("Quên mật khẩu?", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20),
                      const SizedBox(height: 20,),
                      BlockButtonWidget(
                        onPressed: () {
                          controller.login(context);
                        },
                        color: Get.theme.colorScheme.secondary,
                        text: Text(
                          "Đăng nhập",
                          style: Get.textTheme.headline6.merge(
                              TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingSymmetric(vertical: 10, horizontal: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                controller.goToRegisterPage(context);
                              },
                              child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Chưa có tài khoản? ".tr,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      const TextSpan(
                                        text: "Đăng kí",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  )
                              )
                          ),
                        ],
                      ).paddingSymmetric(vertical: 0),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

}

