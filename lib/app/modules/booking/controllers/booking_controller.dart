// ignore_for_file: missing_return, prefer_null_aware_operators

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/provice.dart';
import 'package:vkhealth/app/models/request_models/booking/booking.dart';
import 'package:vkhealth/app/models/request_models/booking/bookinghis_query.dart';
import 'package:vkhealth/app/models/request_models/booking/save_image_file.dart';
import 'package:vkhealth/app/models/request_models/user/all_relation.dart';
import 'package:vkhealth/app/models/response_models/booking/booking_response.dart';
import 'package:vkhealth/app/models/response_models/booking/date_for_service.dart';
import 'package:vkhealth/app/models/response_models/booking/doctor.dart' as doct;
import 'package:vkhealth/app/models/response_models/booking/doctor_working_calendar.dart';
import 'package:vkhealth/app/models/response_models/booking/interval_for_date.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';
import 'package:vkhealth/app/models/response_models/user/profile.dart';
import 'package:vkhealth/app/modules/booking/views/components/booking_success_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/loading_dialog.dart';
import 'package:vkhealth/app/modules/root/controllers/root_controller.dart';
import 'package:vkhealth/app/routes/app_routes.dart';

import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../../../common/ui.dart';
import '../../../models/response_models/booking/booking-history.dart';
import '../../../repositories/booking_repository.dart';
import '../../global_widgets/buttons/big_button.dart';
import '../../global_widgets/buttons/block_button_widget.dart';

class BookingController extends GetxController{
  final haveInsurance = false.obs;
  final currentDotIndex = 0.0.obs;
  Provinces provinces;
  GlobalKey qrKey = GlobalKey(debugLabel: "qrKey");
  Rx<File> choosingFile = File('').obs;
  Rx<Profile> profile = Profile().obs;
  Rx<BookingHistory> history = BookingHistory().obs;
  Rx<BookingRequest> bookingRequest = BookingRequest().obs;
  Rx<BookingResponse> bookingResponse = BookingResponse().obs;
  Rx<DoctorWorkingCalendar> doctorWorkingCalendar = DoctorWorkingCalendar().obs;
  Rx<doct.Doctor> choosenDoctor = doct.Doctor().obs;
  RxList<ServiceModel> services = <ServiceModel>[].obs;
  RxList<doct.Doctor> doctors = <doct.Doctor>[].obs;
  RxList<DateForService> date4Services = <DateForService>[].obs;
  RxList<IntervalForDate> intervalForDate = <IntervalForDate>[].obs;
  AllRelation allRelation;
  final insuranceCode = "".obs;
  final getServicesLoading = false.obs;
  final getHistoryLoading = false.obs;
  final getDoctorsLoading = false.obs;
  final getIntervalForDateLoading = false.obs;
  final getDatesForServiceLoading = false.obs;
  final chooseService = ServiceModel().obs;
  final chooseDate = DateForService().obs;
  final chooseTime = Intervals().obs;
  final chooseDoctor = "".obs;
  final note = "".obs;
  Rx<DateTime> filterFromDate = Rx<DateTime>(null);
  Rx<DateTime> filterToDate = Rx<DateTime>(null);

  BookingRepository _bookingRepository;

  BookingController(){
    _bookingRepository = BookingRepository();
  }

  Future<BookingResponse> booking(BuildContext context) async {
     try{
       showLoadingDialog(context);
       allRelation.insurranceCode = insuranceCode.value;
       try{
         chooseService.value.price = 150000;
         var province = provinces.provinces.where((element) => element.value == allRelation.province).first;
         var district = province.districts.where((element) => element.value == allRelation.district).first;
         var ward = district.wards.where((element) => element.value == allRelation.ward).first;
         allRelation.province = province.label;
         allRelation.district = district.label;
         allRelation.ward = ward.label;
       } catch(e){

       }


       bookingRequest.value = BookingRequest(
           customer: allRelation,
           date: chooseDate.value.date,
           bookedByUser: profile.value.id,
           doctor: chooseDate.value.doctor,
           room: chooseDate.value.room,
           note: chooseDoctor.value,
           service: chooseService.value,
           interval: chooseTime.value,
           exitInformation: ExitInformation(
               destination:  "none",
               entryingDate: "2022-02-10T02:20:51.686Z",
               exitingDate: "2022-02-10T02:20:51.686Z"
           ),
           unit: Unit(
             id: "ad365e31-3e94-4d3e-4256-08d9e32f890c",
             name: "VIỆN TIM TP. HỒ CHÍ MINH",
             information: "none",
             address: "Số 04 Đường Dương Quang Trung",
             username: "none",
             districtCode: "none",
             wardCode: "none",
             provinceCode: "none",
           ),
           testingContent: TestingContent(
             typeTesting:  "none",
             quantity: 0,
             isReceived: true,
             isPickUpAtTheFacility: true,
             receivingAddress:  "none",
             provinceCode:  "none",
             districtCode:  "none",
             wardCode:  "none",
             receiver:  "none",
             note:  "none",
             content:  "none",
             recipientPhoneNumber:  "none",
             result:  "none",
           )
       );
       var result = await _bookingRepository.booking(bookingRequest.value);
       if(choosingFile.value.path.length > 3){
         List<int> imageBytes = choosingFile.value.readAsBytesSync();
         String base64Image = base64Encode(imageBytes);
         saveImageFile(SaveImageRequest(
             examId: result.data.id,
             resultDate: DateTime.now().toIso8601String(),
             result: "0",
             formData: [
               base64Image
             ],
             file: choosingFile.value
         ));
       }
       return result;
     } catch(e){
       Get.showSnackbar(Ui.RemindSnackBar(message: e.toString().replaceAll("Exception: ", "")));
     } finally {
       Navigator.of(context).pop();
     }
  }

  Future<List<doct.Doctor>> getDoctors(BuildContext context) async {
    try {
      var result = await _bookingRepository.getALlDoctor();
      return result.data;
    } catch (e) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Không lấy được thông tin"));
    }
  }

  Future<void> bookingConfirm(BuildContext context, String id, int status) async {
    try {
      showLoadingDialog(context);
      await _bookingRepository.confirmTransfer(id, status);
      Navigator.of(context).pop();
      bookingSuccessDialog(context, title: "Xác nhận thanh toán thành công", firstTitle: "Quay lại",firstTap: (){
        Navigator.of(context).pop();
      }, secondTap: (){
        Get.offAllNamed(Routes.ROOT);
      }, );
    } catch (e) {
      Get.showSnackbar(Ui.RemindSnackBar( message: "Không lấy được thông tin"));
      Navigator.of(context).pop();
    }
  }

  Future<void> getAllRelation(BuildContext context) async {
    try {
      var result = await _bookingRepository.getAllRelation();
      allRelation = result;
      if(result.province == "" || result.province == null ||
          result.district == "" || result.district == null ||
          result.ward == "" || result.ward == null){
        showUpdateInfoNeeded(context);
      }
    } catch (e) {
      Get.showSnackbar(Ui.RemindSnackBar( message: "Không lấy được thông tin"));
    }
  }

  Future<void> saveImageFile(SaveImageRequest request) async {
    try {
    await _bookingRepository.saveImageFile(request);
    } catch (e) {
      return;
    }
  }

  Future<void> getUserProfile(BuildContext context) async{
    try{
      provinces = await Helper().getProvinceFormJson(context);
      var result = await _bookingRepository.getUserProfile();
      profile.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Không lấy được thông tin"));
    } finally {
    }
  }

  Future<void> getIntervalForDate(String dateId, BuildContext context) async {
    getIntervalForDateLoading.value = true;
    try{
      var result = await _bookingRepository.getIntervalForDate(dateId);
      intervalForDate.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Không lấy được thông tin"));
    } finally {
      getIntervalForDateLoading.value = false;
    }
  }
  

  Future<void> getDatesForService(String unitId, String serviceId, BuildContext context) async {
    getDatesForServiceLoading.value = true;
    try{
      var result = await _bookingRepository.getDatesForService(unitId, serviceId);
      date4Services.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Không lấy được thông tin"));
    } finally {
      getDatesForServiceLoading.value = false;
    }
  }

  Future<void> getService(String id, BuildContext context) async {
    getServicesLoading.value = true;
    try{
      var result = await _bookingRepository.getServices(id);
      services.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar(message: "Không lấy được thông tin"));
    } finally {
      getServicesLoading.value = false;
    }

  }


  Future<void> getAllDoctor(BuildContext context) async {
    getServicesLoading.value = true;
    try{
      var result = await _bookingRepository.getALlDoctor();
      doctors.value = result.data;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar(message: "Không lấy được thông tin"));
    } finally {
      getServicesLoading.value = false;
    }

  }

  Future<void> deleteBooking(BuildContext context, String id) async {
    try{
      Navigator.of(context).pop();
      showLoadingDialog(context);
      await _bookingRepository.deleteBooking(id);
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Hủy phiếu hẹn thành công"));
      // Navigator.of(context).pop();
      Get.offAllNamed(Routes.ROOT);
    } catch(e){
      Navigator.of(context).pop();
      Get.showSnackbar(Ui.RemindSnackBar( message: "Xóa thất bại"));
    } finally {


    }
  }

  Future<void> getHistory(BuildContext context) async {
    try{
      getHistoryLoading.value = true;
      var result = await _bookingRepository.getBookingHistory(BookingHisQuery(
        from: filterFromDate.value == null ? null : filterFromDate.value.toIso8601String(),
        to: filterToDate.value == null ? null : filterToDate.value.toIso8601String()
      ));
      history.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Lấy thông tin thất bại"));
    } finally {
      getHistoryLoading.value = false;
    }
  }

  Future<void> getWorkingCalendar(BuildContext context) async {
    try{
      getServicesLoading.value = true;
      var result = await _bookingRepository.getWorkingCalenderByDoctor(choosenDoctor.value.id);
      doctorWorkingCalendar.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Lấy thông tin thất bại"));
    } finally {
      getServicesLoading.value = false;
    }
  }

  void chooseServiceType(String name){
    List<ServiceModel> servicel = services;
    for (var element in servicel) {element.isChoose = false;}
    for (var element in servicel) {if(element.name == name){element.isChoose = true;}}
    services.value = servicel;

  }

  void showRegulationDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(

          content: SizedBox(
            width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.8,
              child: ListView(
                primary: true,
                children: [
                  Center(
                    child: Text(
                      "Quy định",
                      style: TextStyle(
                          fontSize: 20,
                          color: Get.theme.colorScheme.secondary,
                          fontWeight: FontWeight.w700),
                    ),
                  ).paddingOnly(bottom: 20),
                  const Text(
                    "Vui lòng đọc và đồng ý trước khi sử dụng tiếp tục:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Vui lòng đọc và đồng ý trước khi sử dụng tiếp tục:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Thời gian đăng ký khám bệnh trong vòng 15 ngày đến 16h30 trước ngày khám.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Quý khách có thể đăng ký khám 01 khoa.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Phí đăng ký khám trực tuyến bao gồm:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "- Tiền khám chuyên khoa.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Phí tiện ích: phí sử dụng dịch vụ đăng ký khám bệnh trực tuyến, bao gồm phí tin nhắn thông báo lịch hẹn, thông báo giao dịch trên tài khoản thẻ, hủy khám, nhắc tái khám...(chỉ trả 01 lần phí tiện ích cho 01 lượt đăng ký khám nhiều chuyên khoa).",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "● Phương thức thanh toán: Phí khám bệnh được chuyển vào tài khoản thẻ:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "- Các loại thẻ ATM nội địa (đã kích hoạt thanh toán trực tuyến).",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Các thẻ thanh toán quốc tế (Visa/MasterCard…).",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "● Phiếu khám bệnh được gửi đến Quý khách qua email và tin nhắn SMS ngay sau khi đăng ký khám bệnh thành công.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Đến ngày khám, Người bệnh có mặt trước trong vòng 20-30 phút:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Người bệnh đủ điều kiện hưởng BHYT tại Bệnh viện: phải mang theo các giấy tờ cần thiết xác nhận BHYT.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "● Trường hợp hủy hoặc đổi khám:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "- Chỉ thực hiện đến 16h30 trước ngày khám.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Quý khách thực hiện việc hủy phiếu, hoặc hủy phiếu và đặt lịch khám mới trên Website.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Tiền khám bệnh sẽ chuyển lại tài khoản thẻ đã sử dụng thanh toán.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Phí tiện ích sẽ không được hoàn trả.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Thời gian nhận lại tiền khám (Theo quy định của ngân hàng): Các loại thẻ ATM nội địa: từ 01 đến 05 ngày làm việc, Thẻ thanh toán quốc tế (Visa/MasterCard…): từ 05 đến 45 ngày làm việc.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  BlockButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Get.theme.colorScheme.secondary,
                    text: Text(
                      "Đồng ý",
                      style: Get.textTheme.headline6.merge(
                          TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ).paddingSymmetric(vertical: 10,),
                ],
              )),
        );
      },
    );
  }

  void showUpdateInfoNeeded(BuildContext context) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Vui lòng cập nhật địa chỉ trước khi sử dụng tính năng",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          content: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.4,
            child: Column(
              children: [
                Image.asset(
                  "assets/illustration/bonbon-woman-fills-out-a-questionnaire-about-herself.png",
                  height: SizeConfig.screenHeight * 0.2,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                BigButton(
                  title: "Đến trang cập nhật",
                  onTap: (){
                    Get.toNamed(Routes.ROOT);
                    final rootController = Get.find<RootController>();
                    rootController.changePage(3);
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(Routes.ROOT);
                  },
                  child: Text(
                    "Trang chủ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickingFile(BuildContext context) async {
    Get.showSnackbar(Ui.RemindSnackBar( message: "Bạn chưa chọn tệp nào"));
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      choosingFile.value = File(result.files.single.path);
    } else {
      Get.showSnackbar(Ui.RemindSnackBar( message: "Bạn chưa chọn tệp nào"));
    }
  }
}