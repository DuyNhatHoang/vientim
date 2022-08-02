import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/auth/login_request.dart';
import 'package:vkhealth/app/models/request_models/auth/register_request.dart';
import 'package:vkhealth/app/models/request_models/user/password_change.dart';
import 'package:vkhealth/app/models/response_models/user/info.dart';
import 'package:vkhealth/app/models/response_models/user/profile.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/user_model.dart';

class UserRepository {
  DotnetProvider _dotnetProvider;

  UserRepository();

  Future<User> login(LoginRequest request) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.login(request);
  }


  Future<bool> signup(RegisterRequest request) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.signup(request);
  }

  Future<void> changePass(PasswordChange request) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.changePassword(request);
  }

  Future<void> resetPass(String newPass) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.resetPass(newPass);
  }

  Future<UserInfoSwagger> getUserInfor() {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getUserInfo();
  }

  Future<Profile> getUserProfile() {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getUserProfile();
  }

  Future<void> updateUserProfile(Profile profile) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.updateUserProfile(profile);
  }

  Future<void> generateOtp(String phoneNumber) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.generateOtp(phoneNumber);
  }

  Future<void> confirmOtp(String phoneNumber, String otp) {
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.confirmOtp(phoneNumber, otp);
  }


}
