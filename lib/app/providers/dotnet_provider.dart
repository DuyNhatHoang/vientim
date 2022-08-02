// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/auth/login_request.dart';
import 'package:vkhealth/app/models/request_models/auth/register_request.dart';
import 'package:vkhealth/app/models/request_models/booking/booking.dart';
import 'package:vkhealth/app/models/request_models/user/password_change.dart';
import 'package:vkhealth/app/models/response_models/booking/interval_for_date.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';
import 'package:vkhealth/app/models/response_models/user/info.dart';
import 'package:vkhealth/app/models/response_models/user/profile.dart';
import 'package:vkhealth/app/providers/api_provider.dart';
import 'package:vkhealth/app/services/api_service_impl.dart';
import 'package:http_parser/http_parser.dart';
import '../../common/api_constant.dart';
import '../models/request_models/booking/bookinghis_query.dart';
import '../models/request_models/booking/save_image_file.dart';
import '../models/response_models/booking/booking-history.dart';
import '../models/response_models/booking/booking_response.dart';
import '../models/request_models/user/all_relation.dart';
import '../models/response_models/booking/date_for_service.dart';
import '../models/response_models/booking/doctor.dart';
import '../models/response_models/booking/doctor_working_calendar.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'api_provider.dart';

class DotnetProvider extends GetxService with ApiProvider {
  ApiClient _httpClient;

  DotnetProvider(){
    baseUrl = globalService.global.value.apiUrl;
    _httpClient = ApiClient(dio.Dio());
    final authService = Get.find<AuthService>();
    _httpClient.setupToken(authService.apiToken);

  }

  Future<DotnetProvider> init() async {
    return this;
  }

  void forceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
    }
  }

  void unForceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
    }
  }

  Future<User> login(LoginRequest request) async{
    dio.Response response;
    try{
      var body = jsonEncode({
        "username": request.username,
        "password": request.password
      });
      response = await _httpClient.dio.request(
        "${ApiConstants.userAPi}/Users/Login",
        options: Options(
          method: "POST",
        ),
        data: body
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      } else {
        throw Exception(e);
      }
    }
    print('provider - login ${response.data}');
    if (response.statusCode == 200) {
      User user = User.fromJson(response.data);
      user.auth = true;
      user.dateExpired = DateTime.now().add(Duration(seconds: user.expiresIn)).toIso8601String();
      _httpClient.setupToken(user.token);
      return user;
    } else {
      throw Exception(response.data);
    }
  }

  Future<bool> signup(RegisterRequest request) async{
    dio.Response response;
    try{
      // var body = jsonEncode({
      //   "username": request.username,
      //   "password": request.password
      // });
      response = await _httpClient.dio.post(
        "${ApiConstants.userAPi}/Users",
        data: request.toJson(),
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception("Số điện thoại đã tồn tại trên hệ thống");
      }
      throw Exception(e);
    }
    print('provider - signup ${response.data}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<ServiceModel>> getServices(String id) async{
    dio.Response response;
    Map<String, dynamic> queryParams = <String, dynamic>{
      "id": id
    };
    try{
      response = await _httpClient.dio.get<List<dynamic>>(
        "${ApiConstants.scheduleAPi}/Services",
        queryParameters: queryParams,
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getServices ${response.data}');
    if (response.statusCode == 200) {
      List<dynamic> value = response.data
            .map<ServiceModel>((dynamic i){
              return ServiceModel.fromJson(i);
      }).toList();

      return value;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<DateForService>> getDatesForService(String unitId, String serviceId) async{
    dio.Response response;
    unitId = "ad365e31-3e94-4d3e-4256-08d9e32f890c";
    // serviceId = "26288bbd-6ddc-42c2-8555-08da0cad069e";
    Map<String, dynamic> queryParams = <String, dynamic>{
      "serviceId": serviceId,
      "unitId": unitId,
    };
    try{
      response = await _httpClient.dio.get<List<dynamic>>(
        "${ApiConstants.scheduleAPi}/WorkingCalendars/GetDaysByUnitAndService",
        queryParameters: queryParams,
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getDatesForService ${response.data}');
    if (response.statusCode == 200) {
      List<dynamic> value = response.data
          .map<DateForService>((dynamic i){
        return DateForService.fromJson(i);
      }).toList();
      print("sddd ${value.length}");

      return value;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<IntervalForDate>> getIntervalForDate(String dateId) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.post<List<dynamic>>(
        "${ApiConstants.scheduleAPi}/WorkingCalendars/GetIntervals",
        data: "[\"$dateId\"]"
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    log('provider - getIntervalForDate ${response.data}');
    if (response.statusCode == 200) {
      List<dynamic> value = response.data
          .map<IntervalForDate>((dynamic i){
        return IntervalForDate.fromJson(i);
      }).toList();

      return value;
    } else {
      throw Exception(response.data);
    }
  }


  Future<BookingResponse> booking(BookingRequest request) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.post(
          "${ApiConstants.bookingAPi}/Examinations",
          data: request.toJson()
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    log('provider - booking ${response.data}');
    if (response.statusCode == 200) {
      var result = BookingResponse.fromJson(response.data as Map<String , dynamic>);
      return result;
    } else {
      throw Exception(response.data);
    }
  }
  
  Future<Profile> getUserProfile() async{
    dio.Response response;
    try{
      response = await _httpClient.dio.get(
        "${ApiConstants.scheduleAPi}/Profiles",
        // queryParameters: queryParams
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getUserProfile ${response.data}');
    if (response.statusCode == 200) {
      return Profile.fromJson(response.data as Map<String , dynamic>);
    } else {
      throw Exception(response.data);
    }
  }
  
  Future<AllRelation> getAllRelation() async{
    dio.Response response;
    try{
      response = await _httpClient.dio.get<List<dynamic>>(
        "${ApiConstants.scheduleAPi}/Profiles/AllRelation",
        // queryParameters: queryParams
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    log('provider - getAllRelation ${response.data}');
    if (response.statusCode == 200) {
      List<dynamic> value = response.data
          .map<AllRelation>((dynamic i){
        return AllRelation.fromJson(i);
      }).toList();
      return value.first;
    } else {
      throw Exception(response.data);
    }
  }

  Future<Doctors> getAllDoctors() async {
    dio.Response response;
    try{
      response = await _httpClient.dio.get(
          "${ApiConstants.scheduleAPi}/Doctors/GetAllDoctor?pageIndex=1&pageSize=100",
      );
    } catch(e){
        if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getAllDoctors ${response.data}');
    if (response.statusCode == 200) {
        return Doctors.fromJson(response.data as Map<String , dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<DoctorWorkingCalendar> getWorkingCalenderByDoctor(String doctorid) async {
    dio.Response response;
    Map<String, dynamic> queryParams = <String, dynamic>{
      "userid": doctorid,
      "fromDate": "2022-1-10",
      "toDate": "2022-6-10",
    };
    try{
      response = await _httpClient.dio.get(
        "${ApiConstants.scheduleAPi}/WorkingCalendars/GetByDoctor",
        queryParameters: queryParams
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getWorkingCalenderByDoctor ${response.data}');
    if (response.statusCode == 200) {
      try{
        List<dynamic> value = response.data
            .map<DoctorWorkingCalendar>((dynamic i){
          return DoctorWorkingCalendar.fromJson(i);
        }).toList();
        return value.first;
      } catch(e){
        throw Exception(response.data);
      }
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> saveImageFile(SaveImageRequest request) async{
    dio.Response response;
    try{
      dio.FormData formData = dio.FormData.fromMap(request.toJson());
      dio.MultipartFile file = dio.MultipartFile.fromBytes(request.file.readAsBytesSync(),
          filename: DateTime.now().millisecondsSinceEpoch.toString(),
          contentType: MediaType("image", "jpeg"));
      List<MapEntry<String, dio.MultipartFile>> mapEntries = <MapEntry<String, dio.MultipartFile>>[];
      mapEntries.add(MapEntry(
        "FormData",
        file,
      ));
      formData.files.addAll(mapEntries);
      response = await _httpClient.dio.post(
        "${ApiConstants.bookingAPi}/Examinations/SaveFileImages",
        data: formData,
      );
    } catch(e){
      if(e is dio.DioError){
        print("saveImageFile ${e.response.toString()}");
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - saveImageFile ${response.data}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> deleteBooking(String id) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.delete(
        "${ApiConstants.bookingAPi}/Examinations",
        data: jsonEncode({
          "id": id,
          "status": 3
        }),
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - deleteBooking ${response.data}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<BookingHistory> getBookingHistory(BookingHisQuery query) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.get(
        "${ApiConstants.bookingAPi}/Examinations",
        queryParameters: query.toJson()
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getBookingHistory ${response.data}');
    if (response.statusCode == 200) {
      return BookingHistory.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> changePassword(PasswordChange passwordChange) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.put(
          "${ApiConstants.userAPi}/Users/ChangePassword",
        data: passwordChange.toJson()
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - changePassword ${response.data}');
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }

  Future<UserInfoSwagger> getUserInfo() async{
    dio.Response response;
    try{
      response = await _httpClient.dio.get(
          "${ApiConstants.userAPi}/Users/GetUserInfo",
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getUserInfo ${response.data}');
    if (response.statusCode == 200) {
      return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> updateUserProfile(Profile profile) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.put(
        "${ApiConstants.scheduleAPi}/Profiles",
        data: profile.toJson()
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - updateUserProfile ${response.data}');
    if (response.statusCode == 200) {
      return;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> generateOtp(String phoneNumber) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.post(
          "${ApiConstants.userAPi}/Users/ResetPassword/GenerateOTP",
          data: jsonEncode({
            "phoneNumber": phoneNumber,
          })
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - generateOtp ${response.data}');
    if (response.statusCode == 200) {
      return ;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }
  
  Future<void> confirmOtp(String phoneNumber, String otp) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.post(
          "${ApiConstants.userAPi}/Users/ResetPassword/ConfirmOTP",
          data: jsonEncode({"phoneNumber":phoneNumber,"otp": otp})
      );

    } catch(e){
      if(e is dio.DioError){
        throw Exception("OTP không chính xác");
      }
      throw Exception(e);
    }
    print('provider - generateOtp ${response.data}');
    _httpClient.setupToken(response.data['access_token']);
    if (response.statusCode == 200) {
      return ;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }


  Future<void> resetPass(String newPass) async{
    dio.Response response;
    try{
      response = await _httpClient.dio.post(
          "${ApiConstants.userAPi}/Users/ResetPassword",
          data: jsonEncode({"newPassword": newPass})
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.toString());
      }
      throw Exception(e);
    }
    print('provider - resetPass ${response.data}');
    if (response.statusCode == 200) {
      return ;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> transferConfirm(String id, int status) async{
    dio.Response response;
    var body = jsonEncode({
      "id": id,
      "status":status
    });
    try{
      response = await _httpClient.dio.put(
          "${ApiConstants.bookingAPi}/Examinations/Transfer",
          data: body
      );
    } catch(e){
      if(e is dio.DioError){
        throw Exception(e.toString());
      }
      throw Exception(e);
    }
    print('provider - transferConfirm ${response.data}');
    if (response.statusCode == 200) {
      return ;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }
}