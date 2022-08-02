import 'package:get/get.dart';

import '../models/setting_model.dart';

class SettingProvider extends GetxService {

  Future<Setting> getSetttings() async {
    Setting setting = Setting(
      
    );
    return setting;
  }

  Future<SettingProvider> init() async {
    return this;
  }

  // Future<Address> getAddresses() async {}
}
