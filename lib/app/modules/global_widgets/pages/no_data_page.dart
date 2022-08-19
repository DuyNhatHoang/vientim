import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/block_button_widget.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../root/controllers/root_controller.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * .1,),
        Image.asset("assets/icon/dead_file.jpg", height: SizeConfig.screenHeight * 0.3,),
        const Text("Không có dữ liệu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),),
        SizedBox(height: SizeConfig.screenHeight * .01,),
        Text("Chưa tìm thấy thông tin", style: TextStyle(color: Colors.black.withOpacity(.4), fontSize: 18),),
        Text("Vui lòng thử lại sau", style: TextStyle(color: Colors.black.withOpacity(.4), fontSize: 18),),
        BlockButtonWidget(
          onPressed: () {
            final rootController = Get.find<RootController>();
            rootController.changePage(0);
          },
          color: Get.theme.colorScheme.secondary,
          text: Text(
            "Quay về trang chủ",
            style: Get.textTheme.headline6
                .merge(TextStyle(color: Get.theme.primaryColor)),
          ),
        )
            .paddingSymmetric(vertical: 10, horizontal: 20)
            .marginOnly(top: 20, left: 10, right: 10),
      ],
    );
  }
}
