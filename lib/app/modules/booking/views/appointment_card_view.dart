import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vkhealth/app/models/response_models/booking/booking_response.dart';
import 'package:vkhealth/app/modules/booking/controllers/booking_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/comfirm_dialog.dart';
import 'package:vkhealth/app/routes/app_routes.dart';
import 'package:vkhealth/common/helper.dart';

import '../../../../common/size_config.dart';
import '../../../../common/ui.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/pages/base_page.dart';
import 'components/confirm_cancel_dialog.dart';

class AppointmentCardView extends GetView<BookingController> {
  const AppointmentCardView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: "Phiếu hẹn khám",
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.89,
          child: MediaQuery.removeViewPadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15
                          ),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Ui.parseColor("#445c69"),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child:  Text("Phiếu hẹn số ${(Get.arguments as BookingResponseData).interval.numId}".tr,
                              style: TextStyle(
                                  color: Ui.parseColor("#f2ac44"),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                          )
                        )
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10
                          ),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Ui.parseColor("#4e7185"),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("Địa chỉ: ${(Get.arguments as BookingResponseData).unit.address}".tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)).marginOnly(top: 10, bottom: 5),
                              const Divider(color: Colors.white,),
                              Text("Thông tin người khám".tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Họ tên:   ".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                                    TextSpan(
                                      text: (Get.arguments as BookingResponseData).customer.fullname,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                    ),
                                  ],
                                )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Điên thoại:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).customer.phone,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Ngày sinh:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: Helper.getVietnameseTime((Get.arguments as BookingResponseData).customer.birthDate),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Mã bệnh nhân:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).customer.phone,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              const Divider(color: Colors.white,),
                              Text("Thông tin BHYT".tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Mã BHXH:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).customer.insurranceCode,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              const Divider(color: Colors.white,),
                              Text("Thông tin lịch hẹn".tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Dịch vụ y tế:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).service.name,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Ngày khám:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: Helper.getVietnameseTime((Get.arguments as BookingResponseData).date),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Giờ khám:   ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: Helper.getVietnameseTime((Get.arguments as BookingResponseData).interval.from),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Bác sĩ khám:  ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).doctor.fullname,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Phòng khám:  ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).room.name,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Ghi chú:  ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).note,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                              const Divider(color: Colors.white,),
                              Text("Thông tin thanh toán".tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)).marginOnly(top: 10, bottom: 5),
                              Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Thanh toán:  ".tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: (Get.arguments as BookingResponseData).paymentStatus == 0? "Chưa thanh toán" : "Đã thanh toán",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Ui.parseColor("#f2ac44"),),
                                      ),
                                    ],
                                  )
                              ).marginOnly(top: 10, bottom: 5),
                            ],
                        )
                        ),

                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10
                            ),
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                                color: Ui.parseColor("#445c69"),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.4,
                                  child: Column(
                                    children: [
                                      Text("Mã QR".tr,
                                        style: TextStyle(
                                            color: Ui.parseColor("#f2ac44"),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          showComfirmDialog(context, "Bạn có muốn lưu mã QR không?", onSuccessTap: () async {
                                            try{
                                              bool result = await Helper.capturePng(controller.qrKey);
                                              if(result){
                                                Get.showSnackbar(Ui.SuccessSnackBar(message: "Mã QR đã được lưu vào ảnh"));
                                              } else {
                                                Get.showSnackbar(Ui.RemindSnackBar(message: "Lưu mã QR thất bại"));
                                              }
                                            } catch(e){
                                              Get.showSnackbar(Ui.RemindSnackBar(message: "Lưu mã QR thất bại"));
                                            }

                                          });
                                        },
                                        child: RepaintBoundary(
                                          key: controller.qrKey,
                                          child: QrImage(
                                            data: "Tính năng đang phát triển",
                                            version: QrVersions.auto,
                                            backgroundColor: Colors.white,
                                            size: 100.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.4,
                                  child: Column(
                                    children: [
                                      Text("Lưu ý".tr,
                                        style: TextStyle(
                                            color: Ui.parseColor("#f2ac44"),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("- Vui lòng chụp lại thông tin phiếu hẹn để đối chiếu với nhân viên y tế".tr,
                                        style: TextStyle(
                                            color: Ui.parseColor("#f2ac44"),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ).marginOnly(bottom: 10),
                                      Text("- Đến trước 15 phút để kiếm tra thông tin".tr,
                                        style: TextStyle(
                                            color: Ui.parseColor("#f2ac44"),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ).marginOnly(bottom: 10),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(height: 10,),
                        (Get.arguments as BookingResponseData).paymentStatus == 0 ?  BlockButtonWidget(
                          onPressed: () {
                            controller.bookingConfirm(context, (Get.arguments as BookingResponseData).id, 1);
                          },
                          color: Get.theme.colorScheme.secondary,
                          text: SizedBox(
                            width: SizeConfig.screenWidth,
                            child: Center(
                              child: Text(
                                "Xác Nhận Thanh Toán",
                                style: Get.textTheme.headline6.merge(
                                    TextStyle(color: Get.theme.primaryColor)),
                              ),
                            )
                          ),
                        ).paddingSymmetric(vertical: 10, horizontal: 20) : BlockButtonWidget(
                          onPressed: () {
                            Get.toNamed(Routes.ROOT);
                          },
                          color: Get.theme.colorScheme.secondary,
                          text: SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Center(
                                child: Text(
                                  "QUAY VỀ TRANG CHỦ",
                                  style: Get.textTheme.headline6.merge(
                                      TextStyle(color: Get.theme.primaryColor)),
                                ),
                              )
                          ),
                        ).paddingSymmetric(vertical: 10, horizontal: 20),
                        TextButton(onPressed: (){
                          String id = (Get.arguments as BookingResponseData).id;
                          confirmCancelDialog(context, firstTap: (){
                            controller.deleteBooking(context,id);
                          },
                          secondTap: (){
                            Navigator.of(context).pop();
                          });
                          // Navigator.of(context).pop();
                        }, child: const Text(
                          "HỦY PHIẾU HẸN",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),),
                        (Get.arguments as BookingResponseData).paymentStatus == 0 ? TextButton(onPressed: (){
                          Get.offAllNamed(Routes.ROOT);
                          // Navigator.of(context).pop();
                        }, child: const Text(
                          "QUAY VỀ TRANG CHỦ",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),) : Container(),
                      ],
                    ),
                  )
                ],

              )),
        ));
  }
}