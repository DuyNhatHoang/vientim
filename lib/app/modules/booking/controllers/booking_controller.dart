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
             name: "VI???N TIM TP. H??? CH?? MINH",
             information: "none",
             address: "S??? 04 ???????ng D????ng Quang Trung",
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
      Get.showSnackbar(Ui.RemindSnackBar(message: "Kh??ng l???y ???????c th??ng tin"));
    }
  }

  Future<void> bookingConfirm(BuildContext context, String id, int status) async {
    try {
      showLoadingDialog(context);
      await _bookingRepository.confirmTransfer(id, status);
      Navigator.of(context).pop();
      bookingSuccessDialog(context, title: "Xa??c nh????n thanh toa??n tha??nh c??ng", firstTitle: "Quay la??i",firstTap: (){
        Navigator.of(context).pop();
      }, secondTap: (){
        Get.offAllNamed(Routes.ROOT);
      }, );
    } catch (e) {
      Get.showSnackbar(Ui.RemindSnackBar( message: "Kh??ng l???y ???????c th??ng tin"));
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
      Get.showSnackbar(Ui.RemindSnackBar( message: "Kh??ng l???y ???????c th??ng tin"));
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
      Get.showSnackbar(Ui.RemindSnackBar( message: "Kh??ng l???y ???????c th??ng tin"));
    } finally {
    }
  }

  Future<void> getIntervalForDate(String dateId, BuildContext context) async {
    getIntervalForDateLoading.value = true;
    try{
      var result = await _bookingRepository.getIntervalForDate(dateId);
      intervalForDate.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Kh??ng l???y ???????c th??ng tin"));
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
      Get.showSnackbar(Ui.RemindSnackBar( message: "Kh??ng l???y ???????c th??ng tin"));
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
      Get.showSnackbar(Ui.RemindSnackBar(message: "Kh??ng l???y ???????c th??ng tin"));
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
      Get.showSnackbar(Ui.RemindSnackBar(message: "Kh??ng l???y ???????c th??ng tin"));
    } finally {
      getServicesLoading.value = false;
    }

  }

  Future<void> deleteBooking(BuildContext context, String id) async {
    try{
      Navigator.of(context).pop();
      showLoadingDialog(context);
      await _bookingRepository.deleteBooking(id);
      Get.showSnackbar(Ui.SuccessSnackBar(message: "H???y phi???u h???n th??nh c??ng"));
      // Navigator.of(context).pop();
      Get.offAllNamed(Routes.ROOT);
    } catch(e){
      Navigator.of(context).pop();
      Get.showSnackbar(Ui.RemindSnackBar( message: "X??a th???t b???i"));
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
      Get.showSnackbar(Ui.RemindSnackBar( message: "L???y th??ng tin th???t b???i"));
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
      Get.showSnackbar(Ui.RemindSnackBar( message: "L???y th??ng tin th???t b???i"));
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
                      "Quy ?????nh",
                      style: TextStyle(
                          fontSize: 20,
                          color: Get.theme.colorScheme.secondary,
                          fontWeight: FontWeight.w700),
                    ),
                  ).paddingOnly(bottom: 20),
                  const Text(
                    "Vui l??ng ?????c v?? ?????ng ?? tr?????c khi s??? d???ng ti???p t???c:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? Vui l??ng ?????c v?? ?????ng ?? tr?????c khi s??? d???ng ti???p t???c:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? Th???i gian ????ng k?? kh??m b???nh trong v??ng 15 ng??y ?????n 16h30 tr?????c ng??y kh??m.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? Qu?? kh??ch c?? th??? ????ng k?? kh??m 01 khoa.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? Ph?? ????ng k?? kh??m tr???c tuy???n bao g???m:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "- Ti???n kh??m chuy??n khoa.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Ph?? ti???n ??ch: ph?? s??? d???ng d???ch v??? ????ng k?? kh??m b???nh tr???c tuy???n, bao g???m ph?? tin nh???n th??ng b??o l???ch h???n, th??ng b??o giao d???ch tr??n t??i kho???n th???, h???y kh??m, nh???c t??i kh??m...(ch??? tr??? 01 l???n ph?? ti???n ??ch cho 01 l?????t ????ng k?? kh??m nhi???u chuy??n khoa).",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "??? Ph????ng th???c thanh to??n: Ph?? kh??m b???nh ???????c chuy???n v??o t??i kho???n th???:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "- C??c lo???i th??? ATM n???i ?????a (??a?? ki??ch hoa??t thanh toa??n tr????c tuy????n).",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- C??c th??? thanh to??n qu???c t??? (Visa/MasterCard???).",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "??? Phi???u kh??m b???nh ???????c g???i ?????n Qu?? kh??ch qua email v?? tin nh???n SMS ngay sau khi ????ng k?? kh??m b???nh th??nh c??ng.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? ?????n ng??y kh??m, Ng?????i b???nh c?? m???t tr?????c trong v??ng 20-30 ph??t:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? Ng?????i b???nh ????? ??i???u ki???n h?????ng BHYT t???i B???nh vi???n: ph???i mang theo c??c gi???y t??? c???n thi???t x??c nh???n BHYT.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "??? Tr?????ng h???p h???y ho???c ?????i kh??m:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10),
                  const Text(
                    "- Ch??? th???c hi???n ?????n 16h30 tr?????c ng??y kh??m.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Qu?? kh??ch th???c hi???n vi???c h???y phi???u, ho???c h???y phi???u v?? ?????t l???ch kh??m m???i tr??n Website.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Ti???n kh??m b???nh s??? chuy???n l???i t??i kho???n th??? ???? s??? d???ng thanh to??n.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Ph?? ti???n ??ch s??? kh??ng ???????c ho??n tr???.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: 10, left: 25),
                  const Text(
                    "- Th???i gian nh???n l???i ti???n kh??m (Theo quy ?????nh c???a ng??n h??ng): C??c lo???i th??? ATM n???i ?????a: t??? 01 ?????n 05 ng??y l??m vi???c, Th??? thanh to??n qu???c t??? (Visa/MasterCard???): t??? 05 ?????n 45 ng??y l??m vi???c.",
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
                      "?????ng ??",
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
              "Vui l??ng c???p nh???t ?????a ch??? tr?????c khi s??? d???ng t??nh n??ng",
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
                  title: "?????n trang c???p nh???t",
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
                    "Trang chu??",
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
    Get.showSnackbar(Ui.RemindSnackBar( message: "B???n ch??a ch???n t???p n??o"));
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      choosingFile.value = File(result.files.single.path);
    } else {
      Get.showSnackbar(Ui.RemindSnackBar( message: "B???n ch??a ch???n t???p n??o"));
    }
  }
}