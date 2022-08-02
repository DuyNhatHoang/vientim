
import 'package:flutter/material.dart';

import '../../../../../common/size_config.dart';
import '../../../global_widgets/buttons/big_button.dart';


void bookingSuccessDialog(BuildContext context, {String title = "", Function firstTap, Function secondTap, String firstTitle = "Xem phiếu khám",
String secondTitle= "Quay về trang chủ"}) {
  showDialog<void>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Center(
          child: Text(
            "Đặt Khám Thành Công!",
            style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        content: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.4,
          child: Column(
            children: [
              Image.asset(
                "assets/illustration/success_doctor.png",
                height: SizeConfig.screenHeight * 0.2,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              BigButton(
                title: firstTitle,
                onTap: firstTap,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              InkWell(
                onTap: () {
                  secondTap();
                },
                child: Text(
                  secondTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

