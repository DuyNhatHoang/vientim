import 'package:get/get.dart';

import '../../common/helper.dart';
import '../models/global_model.dart';

class GlobalServices extends GetxService{
  final global = Global().obs;

  Future<GlobalServices> init() async{
    var response = await Helper.getJsonFile('config/global.json');
    global.value = Global.fromJson(response);
    return this;
  }

  String get baseUrl => global.value.apiUrl;
}