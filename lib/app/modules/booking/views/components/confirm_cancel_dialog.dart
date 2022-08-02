
import 'package:flutter/material.dart';

import '../../../../../common/size_config.dart';
import '../../../global_widgets/buttons/big_button.dart';


void confirmCancelDialog(BuildContext context, {String title = "", Function firstTap, Function secondTap}) {
  showDialog<void>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Center(
          child: Text(
            "Bạn có chắc muốn hủy phiếu hẹn?",
            style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.4,
          child: Column(
            children: [
              const Text(
                "Đây là thao không thể hoàn tác",
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Image.asset(
                "assets/illustration/fail_doctor.png",
                height: SizeConfig.screenHeight * 0.2,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              BigButton(
                title: "Hủy phếu hẹn",
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
                  "Quay lại",
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

