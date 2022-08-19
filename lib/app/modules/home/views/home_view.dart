
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/home/controllers/home_controller.dart';
import 'package:vkhealth/app/routes/app_routes.dart';
import 'package:vkhealth/common/app_constant.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';
import 'package:vkhealth/common/ui.dart';

import 'components/home_function_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getHistory();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          body: Stack(
        children: [
          Image.asset(
            "assets/img/vtim_image.jpg",
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
                  style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600),
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
                  style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
                ).paddingOnly(left: 15, bottom: 10, top: 35),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                Obx(
                    (){
                      if(controller.history.value.data.isEmpty){
                        return Container();
                      }
                      if(controller.history.value.data.length == 1){
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.history.value.data.last.service.name,
                                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                                  ).marginOnly(bottom: 6),Text(
                                    "Ngày ${Helper.getVietnameseTime(controller.history.value.data.last.date)}",
                                    style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
                                  )

                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.APPOITMENT_CARD, arguments:  controller.history.value.data.last);
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(.7),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Đến xem",
                                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.history.value.data.last.service.name,
                                      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                                    ).marginOnly(bottom: 6),Text(
                                      "Ngày ${Helper.getVietnameseTime(controller.history.value.data.last.date)}",
                                      style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
                                    )

                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.APPOITMENT_CARD, arguments:  controller.history.value.data.last);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(.7),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Đến xem",
                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.history.value.data.reversed.toList()[1].service.name,
                                      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                                    ).marginOnly(bottom: 6),Text(
                                      "Ngày ${Helper.getVietnameseTime(controller.history.value.data.reversed.toList()[1].date)}",
                                      style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
                                    )

                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.APPOITMENT_CARD, arguments:  controller.history.value.data.reversed.toList()[1]);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(.7),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Đến xem",
                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );

                    }
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(AppConstants.version, style: const TextStyle(color: Colors.blue, fontSize: 16),),
            ),
          )
        ],
      )),
    );
  }
}
