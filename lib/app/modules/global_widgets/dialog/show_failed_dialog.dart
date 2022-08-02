
import '../../../../common/size_config.dart';
import '../buttons/big_button.dart';
import 'package:flutter/material.dart';

void showAppFailedDialog(BuildContext context, {String title = "", Function backtap, Function homepageTap}) {
  showDialog<void>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.4,
          child: Column(
            children: [
              Image.asset(
                "assets/illustration/failed_inslutration.png",
                height: SizeConfig.screenHeight * 0.2,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              BigButton(
                title: "Trở lại",
                onTap: backtap,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              InkWell(
                onTap: () {
                  homepageTap();
                },
                child: Text(
                  "Trang chủ",
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