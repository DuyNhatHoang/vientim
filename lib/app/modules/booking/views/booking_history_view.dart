import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/booking/booking_response.dart';
import 'package:vkhealth/app/modules/booking/controllers/booking_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/app/routes/app_routes.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';

class BookingHisView extends GetView<BookingController> {
  const BookingHisView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getHistory(context,);
    return BasePage(
        onBack: (){
          Get.offAllNamed(Routes.ROOT);
        },
        title: "Danh sách lịch hẹn",
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.89,
          child: MediaQuery.removeViewPadding(
              context: context,
              removeTop: true,
              child: Obx(
                  (){
                    return ListView(primary: true, children: _listWidget(context));
                  }
              )),
        ).marginOnly(top: 10));
  }

  List<Widget> _listWidget(BuildContext context){
    List<Widget> list = <Widget>[];
    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: (){
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime.now(),
                onChanged: (date) {}, onConfirm: (date) {
                  controller.filterFromDate.value = date;
                }, currentTime: DateTime.now(), locale: LocaleType.vi);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1)
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.date_range_outlined,
                  size: 18,
                ),
                Text(
                  controller.filterFromDate.value == null ? "  Từ ngày" : "   ${Helper.getVietnameseTime(controller.filterFromDate.value.toIso8601String())}",
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime.now(),
                onChanged: (date) {}, onConfirm: (date) {
                  controller.filterToDate.value = date;
                }, currentTime: DateTime.now(), locale: LocaleType.vi);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1)
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.date_range_outlined,
                  size: 18,
                ),
                Text(
                  controller.filterToDate.value == null ? "  Đến ngày" : "   ${Helper.getVietnameseTime(controller.filterToDate.value.toIso8601String())}",
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                )
              ],
            ),
          ),
        ),
        InkWell(
           onTap: (){
             if(controller.filterFromDate.value == null || controller.filterToDate.value == null){
               Get.showSnackbar(Ui.RemindSnackBar( message: "Vui lòng chọn ngày lọc"));
               return;
             }
             if(!controller.filterToDate.value.isAfter(controller.filterFromDate.value)){
               Get.showSnackbar(Ui.RemindSnackBar( message: "Ngày sau phải lớn hơn ngày trước"));
               return;
             }
             controller.getHistory(context,);

           },
           child: Container(
             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
             decoration: BoxDecoration(
                 color: Colors.black.withOpacity(.6),
                 borderRadius: BorderRadius.circular(10)
             ),
             child: const Text(
               "Lọc",
               style: TextStyle(color: Colors.white, fontSize: 18),
             ),
           ),
         )
      ],
    ));
    // ignore: missing_return
    list.add(Obx((){
      if (controller.getHistoryLoading.value) {
        return const CircularLoadingWidget(
          height: 300,
        );
      } else {
        if(controller.history.value.data != null){
         return Column(children: controller.history.value.data.map((e) => item(e)).toList());
        } else {
          return Container();
        }
      }
    }));
    return list;
  }

  Widget item(BookingResponseData response) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.APPOITMENT_CARD, arguments: response);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(.3),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            Image.asset(
              "assets/icon/recover.png",
              width: 50,
              color: Colors.blue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phiếu hẹn số ${response.interval.numId}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ).marginOnly(bottom: 3, left: 10),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: response.paymentStatus == 0
                          ? Colors.red
                          : Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    response.paymentStatus == 0
                        ? "Chưa thanh toán"
                        : "Đã thanh toán",
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ).marginOnly(bottom: 5, left: 10),
                Text(
                  "${response.interval.from}   ${Helper.getVietnameseTime(response.date)}",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ).marginOnly(bottom: 5, left: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
