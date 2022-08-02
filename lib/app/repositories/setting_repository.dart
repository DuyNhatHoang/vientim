
import 'package:get/get.dart';

import '../models/setting_model.dart';
import '../providers/setting_providers.dart';

class SettingRepository {
  SettingProvider _settingsProvider;

  SettingRepository(){
    _settingsProvider = Get.find<SettingProvider>();
  }

  Future<Setting> get(){
    return _settingsProvider.getSetttings();
  }
  
}
