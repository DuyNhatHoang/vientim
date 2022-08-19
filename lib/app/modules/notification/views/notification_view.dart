import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_constant.dart';
import '../../../../common/helper.dart';
import '../../global_widgets/pages/no_data_page.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController>{
  const NotificationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              primary: true,
              children: const [
              Center(
                  child: Text("Thông báo", style: TextStyle(color: Colors.blue, fontSize: 25),),
                ),
               NoDataPage()
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(AppConstants.version, style: const TextStyle(color: Colors.blue, fontSize: 16),),
              ),
            )
          ],
        ),
      ),
    );

  }

}