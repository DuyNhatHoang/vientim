// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vkhealth/app/repositories/user_repository.dart';

import '../models/user_model.dart';

class AuthService extends GetxService{
  final user = User().obs;
  GetStorage _box;

  UserRepository _userRepository;

  AuthService(){
    _userRepository = UserRepository();
    _box = GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((_user) {
      print("onchange user");
       _box.write("current_user", _user.toJson());
      });
    await getCurrentUser();
    return this;
  }

  Future changeUser(User user) async {
    _box.write("current_user", user.toJson());
    await getCurrentUser();
  }

  Future getCurrentUser() async {
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = User.fromJson(await _box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future removeCurrentUser() async {
    user.value = User();
    // await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  bool get isAuth => user.value.auth ?? false;

  String get apiToken => (user.value.auth ?? false) ? user.value.token : '';

  
}