// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/provice.dart';
import 'package:vkhealth/app/models/request_models/auth/register_request.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/district_select/district_select_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/ward_select/ward_select_dialog.dart';
import 'package:vkhealth/app/routes/app_routes.dart';

import '../../../../common/ui.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/dialog/province_select/province_select_dialog.dart';

class RegisterController extends GetxController{
  final Rx<RegisterRequest> registerRequest = RegisterRequest().obs;
  final loading = false.obs;
  final hidePassword = true.obs;
  final hideCPassword = true.obs;
  Province province;
  Districts district;
  Wards ward;

  GlobalKey<FormState> registerFormKey;
  UserRepository _userRepository;
  RegisterController(){
    _userRepository = UserRepository();
  }

  Future<void> register(BuildContext context) async {
    Get.focusScope.unfocus();
    if(registerFormKey.currentState.validate()){
      registerFormKey.currentState.save();
      if(!_checkConfirmPass(context)){
        return;
      }
      loading.value = true;
      try{
        await _userRepository.signup(registerRequest.value);
        Get.showSnackbar(Ui.SuccessSnackBar(message: "Đăng kí thành công"));
        Get.offAndToNamed(Routes.LOGIN);
      } catch(e){
        Get.showSnackbar(Ui.RemindSnackBar(message: e.toString().replaceAll("Exception: ", "")));
      } finally {
        loading.value = false;
      }
    }
  }

  Future<void> logout() async {
    final authService = Get.find<AuthService>();
    authService.removeCurrentUser();
  }

  Future<void> updateProfile() async{
    try{

    } catch(e){
      return;
    }
  }



  bool _checkConfirmPass(BuildContext context){
    if(registerRequest.value.password != registerRequest.value.confirmPass){
      Get.showSnackbar(Ui.RemindSnackBar(message: "Xác nhận mật khẩu không đúng"));
      return false;
    }
    return true;
  }

  Future<DateTime> chooseBirthDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime _pickerTime;
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: now,
        onChanged: (date) {
        }, onConfirm: (date) {
          _pickerTime = date;
        },
        currentTime: DateTime.now(),
        locale: LocaleType.vi);
    return _pickerTime;
  }

  void chooseProvince(Provinces provinces, BuildContext context){
    showProvinceSelectDialog(context, provinces, (v){
      province = v;
    });
  }

  void chooseDistrict(BuildContext context){
    if(province == null){
      Get.showSnackbar(Ui.RemindSnackBar(message: "Vui lòng chọn Tỉnh/Thành phố"));
      return;
    }
    showDistrictSelectDialog(context, province, (v){
      district = v;
    });
  }

  void chooseWard(BuildContext context){
    if(district == null){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Vui lòng chọn Quận/Huyện"));
      return;
    }
    showWardSelectDialog(context, district, (v){
      ward = v;
    });
  }

}