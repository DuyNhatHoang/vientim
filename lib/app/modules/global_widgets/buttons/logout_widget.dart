import 'package:flutter/material.dart';

import '../../../../common/size_config.dart';

class LogOutWidget extends StatelessWidget {
  final Function onTap;
  const LogOutWidget({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        onLogOutPressed(context);
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.exit_to_app,
                size: SizeConfig.screenWidth * 0.05,
              ),
            ),
            Center(
              child: Text("Đăng Xuất",
                  style: TextStyle(color: Colors.red, fontSize: SizeConfig.screenWidth * 0.04)),
            )
          ],
        ),

      ),
    );
  }
  Future<void> onLogOutPressed(BuildContext context) async {
    onTap();
  }
}
