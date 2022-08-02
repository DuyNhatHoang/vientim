import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/booking/booking.dart';
import 'package:vkhealth/app/models/request_models/user/all_relation.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/request_models/booking/bookinghis_query.dart';
import '../models/request_models/booking/save_image_file.dart';
import '../models/response_models/booking/booking-history.dart';
import '../models/response_models/booking/booking_response.dart';
import '../models/response_models/booking/date_for_service.dart';
import '../models/response_models/booking/doctor.dart';
import '../models/response_models/booking/doctor_working_calendar.dart';
import '../models/response_models/booking/interval_for_date.dart';
import '../models/response_models/user/profile.dart';

class BookingRepository {
  DotnetProvider _dotnetProvider;

  BookingRepository();

  Future<List<ServiceModel>> getServices(String id){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getServices(id);
  }

  Future<List<DateForService>> getDatesForService(String unitId, String serviceId){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getDatesForService(unitId, serviceId);
  }

  Future<List<IntervalForDate>> getIntervalForDate(String dateId){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getIntervalForDate(dateId);
  }

  Future<Profile> getUserProfile(){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getUserProfile();
  }

  Future<Doctors> getALlDoctor(){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getAllDoctors();
  }

  Future<AllRelation> getAllRelation(){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getAllRelation();
  }

  Future<BookingResponse> booking(BookingRequest request){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.booking(request);
  }

  Future<void> saveImageFile(SaveImageRequest request){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.saveImageFile(request);
  }

  Future<void> deleteBooking(String id){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.deleteBooking(id);
  }

  Future<BookingHistory> getBookingHistory(BookingHisQuery query){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getBookingHistory(query);
  }

  Future<DoctorWorkingCalendar> getWorkingCalenderByDoctor(String doctorid){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getWorkingCalenderByDoctor(doctorid);
  }

  Future<void> confirmTransfer(String id, int status){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.transferConfirm(id, status);
  }
}
