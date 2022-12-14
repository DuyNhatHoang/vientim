import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';
import 'package:vkhealth/app/modules/booking/controllers/booking_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/block_button_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/radio_group/src/radio_button_builder.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/radio_group/src/radio_group.dart';
import 'package:vkhealth/common/app_constant.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../../common/size_config.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/calendar/widget/my_calendar.dart';
import '../../global_widgets/dialog/choose_doctor/choose_doctor_dialog.dart';
import '../../global_widgets/text_field_widget.dart';

class ExpertBookingView extends GetView<BookingController> {
  const ExpertBookingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => controller.showRegulationDialog(context));
    controller.getAllRelation(context);
    controller.getUserProfile(context);
    return WillPopScope(
      onWillPop: (){
        Get.toNamed(Routes.ROOT);
        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/img/bg1.png",
                    width: SizeConfig.screenWidth,
                  ),
                  ListView(
                    primary: true,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Obx(() {
                        return DotsIndicator(
                          dotsCount: 6,
                          position: controller.currentDotIndex.value,
                          decorator: const DotsDecorator(
                              color: Colors.white, // Inactive color
                              activeColor: Colors.blue,
                              size: Size(7, 7)),
                        );
                      }),
                    ],
                  ),
                ],
              ),
              Obx(() {
                return getCurrentWidget(
                    controller.currentDotIndex.value.toInt(), context);
              }),
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

  Widget getCurrentWidget(int index, BuildContext context) {
    switch (index) {
      case 0:
        return chooseInsuranceType(context);
      case 1:
        return chooseDoctor(context);
        case 2:
        return chooseMedicalService(context,);
      case 3:
        return chooseDate(context,);
      case 4:
        return chooseTime(context,);
      case 5:
        return chooseReferralDoctor(context);
    // case 4 :
    //   return writeNote();
    }
    return Container();
  }

  Widget chooseInsuranceType(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: ListView(
          primary: true,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "S??? d???ng b???o hi???m y t????",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                const Text(
                  "",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ).marginOnly(bottom: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "C?? s??? d???ng BHYT",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Radio<bool>(
                  value: controller.haveInsurance.value,
                  groupValue: true,
                  onChanged: (value) {
                    controller.haveInsurance.value = true;
                  },
                ),
              ],
            ).marginSymmetric(horizontal: 20),
            controller.haveInsurance.value
                ? Column(
              children: [
                const Text(
                  "\"????? s??? d???ng b???o hi???m y t???, ng?????i kh??m c???n c?? gi???y chuy???n vi???n ho???c gi???y h???n c???a b??c s?? c??n th???i h???n\"",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ).paddingSymmetric(horizontal: 30),
                Row(
                  children: [
                    const Text(
                      "Ch???n t???p ????nh k??m:   ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        controller.pickingFile(context,);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Ui.parseColor("#f2efed")),
                        child: const Text(
                          "Ch???n t???p",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ).marginSymmetric(vertical: 10, horizontal: 10),
                Obx(() {
                  return controller.choosingFile.value.path.isNotEmpty
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          controller.choosingFile.value.path
                              .split("/")
                              ?.last,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        width: SizeConfig.screenWidth * 0.8,
                      ),
                      InkWell(
                        onTap: () {
                          controller.choosingFile.value = File("");
                        },
                        child: Container(
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle),
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.only(left: 4),
                        ),
                      )
                    ],
                  )
                      : const SizedBox();
                }),
                const SizedBox(
                  height: 10,
                ),
                Obx((){
                  return TextFieldWidget(
                    labelText: "Nh???p m?? s???  b???o hi???m c???a b???n".tr,
                    hintText: "M?? c???a b???n",
                    initialValue: controller.insuranceCode.value,
                    isEdit: true,
                    onChanged: (s){
                      controller.insuranceCode.value = s;
                    },
                    style:
                    const TextStyle(color: Colors.black, fontSize: 18),
                    validator: (input) => input.isEmpty
                        ? "M?? s??? b???o hi???m kh??ng h???p l???".tr
                        : null,
                    iconData: Icons.credit_card_sharp,
                  );
                })
              ],
            )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kh??ng c?? BHYT",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Radio<bool>(
                  value: controller.haveInsurance.value,
                  groupValue: false,
                  onChanged: (value) {
                    controller.haveInsurance.value = false;
                  },
                ),
              ],
            ).marginSymmetric(horizontal: 20),
            BlockButtonWidget(
              onPressed: () {
                if(controller.haveInsurance.value && controller.insuranceCode.value == ""){
                  Get.showSnackbar(Ui.RemindSnackBar( message: "B???n ch??a nh???p m?? b???o hi???m y t???"));
                  return;
                }

                if (controller.currentDotIndex.value == 4) {
                  controller.currentDotIndex.value = 0.0;
                  return;
                }
                controller.currentDotIndex.value =
                    controller.currentDotIndex.value + 1.0;
              },
              color: Get.theme.colorScheme.secondary,
              text: Text(
                "Ti???p theo",
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: Get.theme.primaryColor)),
              ),
            )
                .paddingSymmetric(vertical: 10, horizontal: 20)
                .marginOnly(top: 20),
          ],
        ),
      );
    });
  }

  Widget chooseDoctor(BuildContext context) {
    controller.getAllDoctor(context,);
    return Container(
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: ListView(
          primary: true,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (controller.currentDotIndex.toInt() != 0) {
                      controller.currentDotIndex.value -= 1;
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "Ch???n ba??c si??",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                const Text(
                  "",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ).marginOnly(bottom: 20),
            InkWell(
              onTap: (){
                showDoctorsDialog(
                    context,
                    controller.doctors,
                        // ignore: missing_return
                        (s){
                      controller.choosenDoctor.value = s;
                        }
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                        (){
                          return controller.choosenDoctor.value.fullName != null ?  Text(controller.choosenDoctor.value.fullName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18
                            ),) : const Text("Cho??n ba??c si??",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 18
                            ),);
                        }
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
            BlockButtonWidget(
              onPressed: () {
                if (controller.choosenDoctor.value.fullName == null) {
                  Get.showSnackbar(
                      Ui.RemindSnackBar( message: "B???n ch??a cho??n ba??c si??"));
                  return;
                }
                if (controller.currentDotIndex.value == 5) {
                  controller.currentDotIndex.value = 0.0;
                  return;
                }
                controller.currentDotIndex.value =
                    controller.currentDotIndex.value + 1.0;
                // controller.chooseService.value = ServiceModel();
              },
              color: Get.theme.colorScheme.secondary,
              text: Text(
                "Ti???p theo",
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: Get.theme.primaryColor)),
              ),
            )
                .paddingSymmetric(vertical: 10, horizontal: 20)
                .marginOnly(top: 20),
          ],
        ));
  }

  Widget chooseMedicalService(BuildContext context) {
    if (controller.chooseService.value.name == null) {
      controller.getWorkingCalendar(context);
    }
    return Container(
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: ListView(
          primary: true,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (controller.currentDotIndex.toInt() != 0) {
                      controller.currentDotIndex.value -= 1;
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "Ch???n d???ch v??? y t???",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                const Text(
                  "",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ).marginOnly(bottom: 20),
            // const SearchWidget(
            //   title: "Lo???i d???ch v???",
            // ),
            Obx(() {
              return controller.doctorWorkingCalendar.value.serviceModel != null ?  RadioGroup<ServiceModel>.builder(
                groupValue: controller.chooseService.value,
                items: controller.doctorWorkingCalendar.value.serviceModel,
                activeColor: Colors.black,
                itemBuilder: (item) => RadioButtonBuilder(
                  item.name,
                ),
                onChanged: (s) {
                  controller.chooseService.value = s;
                },
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ) : const Center(child: Text("Kh??ng co?? di??ch vu??", style: TextStyle(color: Colors.black, fontSize: 18)),);
            }),
            BlockButtonWidget(
              onPressed: () {
                if (controller.chooseService.value.name == null) {
                  Get.showSnackbar(
                      Ui.RemindSnackBar( message: "B???n ch??a ch???n d???ch v??? n??o"));
                  return;
                }
                if (controller.currentDotIndex.value == 4) {
                  controller.currentDotIndex.value = 0.0;
                  return;
                }
                controller.currentDotIndex.value =
                    controller.currentDotIndex.value + 1.0;
                // controller.chooseService.value = ServiceModel();
              },
              color: Get.theme.colorScheme.secondary,
              text: Text(
                "Ti???p theo",
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: Get.theme.primaryColor)),
              ),
            )
                .paddingSymmetric(vertical: 10, horizontal: 20)
                .marginOnly(top: 20),
          ],
        ));
  }

  Widget chooseDate(BuildContext context) {
    controller.getDatesForService("", controller.chooseService.value.id, context);
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ListView(
        primary: true,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.currentDotIndex.toInt() != 0) {
                    controller.currentDotIndex.value -= 1;
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              const Text(
                "Ch???n ng??y",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const Text(
                "",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ).marginOnly(bottom: 20),
          Obx(() {
            return MyCalendar(
              initialDate: DateTime.now(),
              onChange: (d){
                controller.chooseDate.value = controller.date4Services.firstWhere(
                        (element) => DateTime.parse(element.date).day == d.day && DateTime.parse(element.date).month == d.month);
              },
              availableDates: controller.date4Services
                  .map((element) => DateTime.parse(element.date))
                  .toList(),
            );
          }),
          BlockButtonWidget(
            onPressed: () {
              if(controller.chooseDate.value.id == null){
                Get.showSnackbar(Ui.RemindSnackBar( message: "Ba??n ch??a cho??n nga??y"));
              } else {
                if (controller.currentDotIndex.value == 4) {
                  controller.currentDotIndex.value = 0.0;
                  return;
                }
                controller.currentDotIndex.value =
                    controller.currentDotIndex.value + 1.0;
              }
            },
            color: Get.theme.colorScheme.secondary,
            text: Text(
              "Ti???p theo",
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20).marginOnly(top: 20),
        ],
      ),
    );
  }

  Widget chooseTime(BuildContext context) {
    controller.getIntervalForDate(controller.chooseDate.value.id, context);
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ListView(
        primary: true,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.currentDotIndex.toInt() != 0) {
                    controller.currentDotIndex.value -= 1;
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              const Text(
                "Ch???n th???i gian",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const Text(
                "",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ).marginOnly(bottom: 20),
          Text("Bu???i s??ng".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
              .marginOnly(left: 10, top: 10, bottom: 10),
          Obx((){
            return controller.intervalForDate.isNotEmpty ? Wrap(
                children: controller.intervalForDate.where((element) => int.parse(element.from.split(":").first) <= 12)
                    .map((element){
                  return ChoiceChip(
                    selected: controller.chooseTime.value.numId == element.intervals.first.numId,
                    onSelected: (s){
                      for(var i in element.intervals){
                        if(i.availableQuantity > 0){
                          controller.chooseTime.value = i;
                        }
                        return;
                      }
                      controller.chooseTime.value = element.intervals.first;
                    },
                    selectedColor: Colors.blue,
                    disabledColor: Colors.grey.withOpacity(.1),
                    label: Text("${element.from} - ${element.to}", style: const TextStyle(color: Colors.black, fontSize: 14),),
                  ).marginAll(10);
                })
                    .toList()) : Container();
          }),
          Text("Bu???i chi???u".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
              .marginOnly(left: 10, top: 10, bottom: 10),
          Obx((){
            return controller.intervalForDate.isNotEmpty ?Wrap(
                children: controller.intervalForDate.first.intervals.where((element) => int.parse(element.from.split(":").first) > 12)
                    .map((element){
                  return ChoiceChip(
                    selected: controller.chooseTime.value .numId== element.numId,
                    onSelected: (s){
                      controller.chooseTime.value.numId = element.numId;
                    },
                    selectedColor: Colors.blue,
                    disabledColor: Colors.grey.withOpacity(.1),
                    label: Text("${element.from} - ${element.to}", style: const TextStyle(color: Colors.black, fontSize: 14),),
                  ).marginAll(10);
                })
                    .toList()) : Container();
          }),
          BlockButtonWidget(
            onPressed: () {
              if (controller.currentDotIndex.value == 5) {
                controller.currentDotIndex.value = 0.0;
                return;
              }
              controller.currentDotIndex.value =
                  controller.currentDotIndex.value + 1.0;
            },
            color: Get.theme.colorScheme.secondary,
            text: Text(
              "Ti???p theo",
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20).marginOnly(top: 20),
        ],
      ),
    );
  }

  Widget writeNote() {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ListView(
        primary: true,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.currentDotIndex.toInt() != 0) {
                    controller.currentDotIndex.value -= 1;
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              const Text(
                "Th??m ghi ch??",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const Text(
                "",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ).marginOnly(bottom: 20),
          Text("Th??m ghi ch??".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
              .marginOnly(left: 10, top: 10, bottom: 10),
          TextFormField(
            onChanged: (s){
              controller.note.value = s;
            },
            style: const TextStyle(
                color: Colors.black
            ),
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black
                  ),
                )
            ),
            maxLines: 4,
          ).marginAll(10),

          BlockButtonWidget(
            onPressed: () {
              Get.toNamed(Routes.CONFIRM_BOOKING, arguments: 0);
            },
            color: Get.theme.colorScheme.secondary,
            text: Text(
              "X??c nh???n",
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20).marginOnly(top: 20),
        ],
      ),
    );
  }

  Widget chooseReferralDoctor(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ListView(
        primary: true,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.currentDotIndex.toInt() != 0) {
                    controller.currentDotIndex.value -= 1;
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              const Text(
                "Ch???n b??c s?? gi???i thi???u",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const Text(
                "",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ).marginOnly(bottom: 20),
          const Text(
            "NH???P TH??NG TIN B??C S?? GI???I THI???U (N???U C??):",
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
          ).paddingSymmetric(horizontal: 30),
          TextFieldWidget(
            // isEdit: false,
            labelText: "Nh???p t??n b??c s?? ho???c ghi ch??".tr,
            labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            hintText: "",
            initialValue: "",
            onChanged: (s) => controller.chooseDoctor.value = s,
            iconData: Icons.drive_file_rename_outline,
          ),
          BlockButtonWidget(
            onPressed: () {
              Get.toNamed(Routes.CONFIRM_BOOKING, arguments: 0);
            },
            color: Get.theme.colorScheme.secondary,
            text: Text(
              "X??c nh???n",
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20).marginOnly(top: 20),
        ],
      ),
    );
  }
}
