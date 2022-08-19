import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';
import 'package:vkhealth/app/modules/booking/controllers/booking_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/block_button_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/radio_group/src/radio_button_builder.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/radio_group/src/radio_group.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../../common/app_constant.dart';
import '../../../../common/size_config.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/calendar/widget/my_calendar.dart';
import '../../global_widgets/text_field_widget.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => controller.showRegulationDialog(context));
    controller.getAllRelation(context);
    controller.getUserProfile(context);
    return WillPopScope(
      onWillPop: (){
        Get.offAllNamed(Routes.ROOT);
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
                          dotsCount: 5,
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
        return chooseMedicalService(context,);
      case 2:
        return chooseDate(context,);
      case 3:
        return chooseTime(context,);
      case 4:
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
                  "Sử dụng bảo hiểm y tế?",
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
                  "Có sử dụng BHYT",
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
                        "\"Để sử dụng bảo hiểm y tế, người khám cần có giấy chuyển viện hoặc giấy hẹn của bác sĩ còn thời hạn\"",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ).paddingSymmetric(horizontal: 30),
                      Row(
                        children: [
                          const Text(
                            "Chọn tệp đính kém:   ",
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
                                "Chọn tệp",
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
                          labelText: "Nhập mã số  bảo hiểm của bạn".tr,
                          hintText: "Mã của bạn",
                          initialValue: controller.insuranceCode.value,
                          isEdit: true,
                          onChanged: (s){
                            controller.insuranceCode.value = s;
                          },
                          style:
                          const TextStyle(color: Colors.black, fontSize: 18),
                          validator: (input) => input.isEmpty
                              ? "Mã số bảo hiểm không hợp lệ".tr
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
                  "Không có BHYT",
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
                  Get.showSnackbar(Ui.RemindSnackBar( message: "Bạn chưa nhập mã bảo hiểm y tế"));
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
                "Tiếp theo",
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

  Widget chooseMedicalService(BuildContext context) {
    if (controller.chooseService.value.name == null) {
      controller.getService("", context,);
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
                  "Chọn dịch vụ y tế",
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
            //   title: "Loại dịch vụ",
            // ),
            Obx(() {
              return !controller.getServicesLoading.value
                  ? RadioGroup<ServiceModel>.builder(
                      groupValue: controller.chooseService.value,
                      items: controller.services.where((p0) => p0.isBooking == true).toList(),
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
                    )
                  : const CircularLoadingWidget(height: 300);
            }),
            BlockButtonWidget(
              onPressed: () {
                if (controller.chooseService.value.name == null) {
                  Get.showSnackbar(
                      Ui.RemindSnackBar( message: "Bạn chưa chọn dịch vụ nào"));
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
                "Tiếp theo",
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
    controller.getDatesForService("", controller.chooseService.value.id, context,);
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
                "Chọn ngày",
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
               Get.showSnackbar(Ui.RemindSnackBar( message: "Bạn chưa chọn ngày"));
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
              "Tiếp theo",
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20).marginOnly(top: 20),
        ],
      ),
    );
  }

  Widget chooseTime(BuildContext context) {
    controller.getIntervalForDate(controller.chooseDate.value.id, context,);
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
                "Chọn thời gian",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const Text(
                "",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ).marginOnly(bottom: 20),
          Text("Buổi sáng".tr,
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
          Text("Buổi chiều".tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))
              .marginOnly(left: 10, top: 10, bottom: 10),
          Obx((){
            return controller.intervalForDate.isNotEmpty ? Wrap(
                children: controller.intervalForDate.where((element) => int.parse(element.from.split(":").first) > 12)
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
          BlockButtonWidget(
            onPressed: () {
              if (controller.currentDotIndex.value == 4) {
                controller.currentDotIndex.value = 0.0;
                return;
              }
              controller.currentDotIndex.value =
                  controller.currentDotIndex.value + 1.0;
            },
            color: Get.theme.colorScheme.secondary,
            text: Text(
              "Tiếp theo",
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
                "Thêm ghi chú",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const Text(
                "",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ).marginOnly(bottom: 20),
          Text("Thêm ghi chú".tr,
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
              "Xác nhận",
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
                "Chọn bác sĩ giới thiệu",
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
            "NHẬP THÔNG TIN BÁC SĨ GIỚI THIỆU (NẾU CÓ):",
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
          ).paddingSymmetric(horizontal: 30),
          TextFieldWidget(
            // isEdit: false,
            labelText: "Nhập tên bác sĩ hoặc ghi chú".tr,
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
              "Xác nhận",
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20).marginOnly(top: 20),
        ],
      ),
    );
  }
}
