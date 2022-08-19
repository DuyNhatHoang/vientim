
// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:vkhealth/app/modules/auth/controllers/auth_controller.dart';

import '../../../../../common/ui.dart';
import '../../../global_widgets/buttons/block_button_widget.dart';


class OtpView extends GetView<AuthController> {
  const OtpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        primary: true,
        children: [
          const SizedBox(height: 20,),
          Image.asset("assets/icon/vientiem.png", height: 150,),
          const SizedBox(height: 20,),

          Center(
            child: Text("Xác nhận OTP".tr, style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold),),
          ), const SizedBox(height: 20,),
          Center(
            child: Text("Đang gửi OTP đến số ${controller.phoneNumber}".tr, style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold),),
          ),
          OtpPinField(
            onSubmit: (text) {
              controller.otp.value = text;
            // return the entered pin
            },
            // to decorate your Otp_Pin_Field
            otpPinFieldStyle: const OtpPinFieldStyle(
              // border color for inactive/unfocused Otp_Pin_Field
              defaultFieldBorderColor: Colors.grey,
              // border color for active/focused Otp_Pin_Field
              activeFieldBorderColor: Colors.blue,
              // Background Color for inactive/unfocused Otp_Pin_Field
              defaultFieldBackgroundColor: Colors.white,
              activeFieldBackgroundColor: Colors
                  .cyanAccent, // Background Color for active/focused Otp_Pin_Field
            ),
            maxLength: 6,

            otpPinFieldDecoration:
            OtpPinFieldDecoration.underlinedPinBoxDecoration,
          ),
          BlockButtonWidget(
            onPressed: () {
              if(controller.otp.value.length < 6){
                Get.showSnackbar(Ui.RemindSnackBar(message: "Vui lòng nhập đủ 6 ký tự".replaceAll("Exception: ", "")));
                return;
              }
              controller.confirmOtp(context);
            },
            color: Get.theme.colorScheme.secondary,
            text: Text(
              "Xác nhận",
              style: Get.textTheme.headline6.merge(
                  TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 50, horizontal: 20),
        ],
      ),
    );
  }

}

