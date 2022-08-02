// ignore_for_file: avoid_print

import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../app/models/provice.dart';
import 'ui.dart';

class Helper {
  DateTime currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static Future<bool> capturePng(GlobalKey key) async {
    try{
      RenderRepaintBoundary boundary = key.currentContext.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      final directory = await getApplicationDocumentsDirectory();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File file = File("${directory.path}/image.png");
      await file.writeAsBytes(pngBytes);
      var result = await GallerySaver.saveImage(file.path, albumName: "Vientiem");
      // await file.delete();
      return true;
    } catch(e){
      print("_capturePng $e");
      return false;
    }
  }

  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    print(files);
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String getVietnameseTime(String isoString){
     try{
         DateTime dateTime = DateTime.parse(isoString);
         return "${dateTime.day} - ${dateTime.month} - ${dateTime.year} ";
     } catch(e){
       return "";
     }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Nhấn lần nữa để thoát!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  Future<Provinces> getProvinceFormJson(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/hanhchinhvn/locations.json");
    final jsonResult = jsonDecode(data);
    Provinces provinces = Provinces.fromJson(jsonResult);
    print("getProvinceFormJson ${provinces.provinces.length}");
    return provinces;
  }
}
