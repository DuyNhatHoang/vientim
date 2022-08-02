import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/home/controllers/home_controller.dart';
import 'package:vkhealth/app/routes/app_routes.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';
import 'package:vkhealth/common/ui.dart';

import 'components/home_function_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          body: Stack(
        children: [
          Image.asset(
            "assets/img/bg1.png",
            width: SizeConfig.screenWidth,
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: ListView(
              primary: true,
              children: [
                const Text(
                  "Dịch vụ của tôi",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ).paddingOnly(left: 15, bottom: 10),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeFunctionCard(
                      title: "Đặt lịch khám bệnh",
                      onTap: () {
                        Get.toNamed(Routes.BOOKING);
                      },
                      image: "assets/icon/calendar-tick.png",
                      bgColor: Ui.parseColor("#E86993"),
                    ),
                    HomeFunctionCard(
                        title: "Đặt lịch chuyên gia",
                        onTap: () {
                          Get.toNamed(Routes.EXPERT_BOOKING);
                        },
                        image: "assets/icon/doctor.png",
                        bgColor: Ui.parseColor("#139cd6")),
                  ],
                ).marginOnly(bottom: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeFunctionCard(
                        title: "Lịch sử đặt lịch",
                        onTap: () {
                          Get.toNamed(Routes.BOOKING_HIS);
                        },
                        image: "assets/icon/recover.png",
                        bgColor: Ui.parseColor("#219653")),
                    HomeFunctionCard(
                        title: "",
                        onTap: () {
                          Get.toNamed(Routes.BOOKING_HIS);
                        },
                        image: "assets/icon/recover.png",
                        bgColor: Colors.transparent),
                  ],
                ),
                const Text(
                  "Lịch hẹn sắp tới của bạn",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ).paddingOnly(left: 15, bottom: 10, top: 35),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
