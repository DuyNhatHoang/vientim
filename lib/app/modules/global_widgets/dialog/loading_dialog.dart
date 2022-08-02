import 'package:flutter/material.dart';

import '../../../../common/size_config.dart';

void showLoadingDialog(BuildContext context){
  SizeConfig().init(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05))
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.25),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.4)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/img/loading_gif.gif", width: SizeConfig.screenWidth * 0.15,),
              const Text("Đang tải...", style: TextStyle(color: Colors.black),)
            ],
          ),
        ),
      );
    },
  );
}