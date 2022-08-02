import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/share/controllers/share_controller.dart';

import '../../../../common/helper.dart';

class ShareView extends GetView<ShareController>{
  const ShareView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: const Scaffold(
        body: Text("share view"),
      ),
    );
  }


}