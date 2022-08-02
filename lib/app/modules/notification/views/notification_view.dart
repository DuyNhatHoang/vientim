import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController>{
  const NotificationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: const Scaffold(
        body: Text("Tính năng đang phát triển"),
      ),
    );

  }

}