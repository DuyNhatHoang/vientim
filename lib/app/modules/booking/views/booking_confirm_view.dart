import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/booking/controllers/booking_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/comfirm_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import 'components/booking_success_dialog.dart';

class BookingConfirmView extends GetView<BookingController> {
  const BookingConfirmView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: "Xác nhận đăng kí lịch hẹn",
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.89,
          child: MediaQuery.removeViewPadding(
              context: context,
              removeTop: true,
              child: Obx(
                  (){
                    return ListView(
                      children: [
                        Text("Thông tin lịch hẹn".tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold))
                            .marginOnly(left: 10, top: 10, bottom: 10),
                        TextFieldWidget(
                          isEdit: false,
                          labelText: "Địa điểm".tr,
                          hintText: "Viện tim TP.HCM",
                          initialValue: "Viện tim TP.HCM",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          labelText: "Địa chỉ".tr,
                          hintText: "Số 4 Quang Trung",
                          initialValue: "Số 4 Quang Trung",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        Text("Thông tin người khám".tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                            .marginOnly(left: 10, top: 10, bottom: 10),
                        TextFieldWidget(
                          labelText: "Họ và tên".tr,
                          hintText: "Số 4 Quang Trung",
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          initialValue: controller.profile.value.fullname,
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Ngày sinh".tr,
                          initialValue: Helper.getVietnameseTime(controller.profile.value.dateOfBirth),
                          hintText: "",
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Số điện thoại".tr,
                          initialValue: controller.profile.value.phoneNumber,
                          hintText: "",
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Mã BHYT".tr,
                          initialValue: controller.insuranceCode.value,
                          hintText: "",
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        Text("Thông tin lịch hẹn".tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                            .marginOnly(left: 10, top: 10, bottom: 10),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Dịch vụ y tế".tr,
                          hintText: "Số 4 Quang Trung",
                          initialValue: controller.chooseService.value.name,
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Ngày khám".tr,
                          initialValue: Helper.getVietnameseTime(controller.chooseDate.value.date),
                          hintText: "",
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Giờ khám".tr,
                          hintText: "Số 4 Quang Trung",
                          initialValue: "${controller.chooseTime.value.from} - ${controller.chooseTime.value.to}",
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Bác sĩ khám".tr,
                          hintText: "Số 4 Quang Trung",
                          initialValue: controller.chooseDate.value.doctor.fullName,
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        // TextFieldWidget(
                        //   labelText: "Phòng khám".tr,
                        //   hintText: "Số 4 Quang Trung",
                        //   labelStyle: const TextStyle(
                        //       fontSize: 18,
                        //       color: Colors.black
                        //   ),
                        //   validator: (input) =>
                        //   input.isEmpty
                        //       ? "Thông tin không được trống".tr
                        //       : null,
                        // ),
                        TextFieldWidget(
                          isEdit: false,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          labelText: "Ghi chú".tr,
                          initialValue: controller.chooseDoctor.value,
                          hintText: "",
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          validator: (input) =>
                          input.isEmpty
                              ? "Thông tin không được trống".tr
                              : null,
                        ),
                        BlockButtonWidget(
                          onPressed: () async {
                            try{
                              var result = await controller.booking(context);
                              if(result != null){
                                bookingSuccessDialog(context, firstTap: (){
                                  Get.toNamed(Routes.APPOITMENT_CARD, arguments: result.data);
                                }, secondTap: (){
                                  Get.offAllNamed(Routes.ROOT);
                                });
                              }
                            } catch(e){
                              return;
                            }

                          },
                          color: Get.theme.colorScheme.secondary,
                          text: Text(
                            "XÁC NHẬN ĐẶT LỊCH",
                            style: Get.textTheme.headline6.merge(
                                TextStyle(color: Get.theme.primaryColor)),
                          ),
                        ).paddingSymmetric(vertical: 10, horizontal: 20),
                        TextButton(onPressed: (){
                          showComfirmDialog(context, "Bạn có chắc muốn hủy đặt lịch không?", onSuccessTap: (){
                            Get.showSnackbar(Ui.RemindSnackBar( message: "Bạn đã hủy đăng kí lịch"));
                            Get.offAllNamed(Routes.ROOT);
                          });
                        
                        }, child: const Text(
                          "HỦY ĐẶT LỊCH",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),)
                      ],

                    );
                  }
              )),
        ));
  }
}
