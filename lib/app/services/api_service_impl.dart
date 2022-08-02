// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../common/api_constant.dart';

class ApiClient{
  final Dio dio;

  ApiClient(this.dio);

  ApiClient setupToken(String accessToken){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.options = BaseOptions(
        receiveTimeout: ApiConstants.timeout,
        connectTimeout: ApiConstants.timeout);
    dio.options.headers["Authorization"] = "Bearer $accessToken";
    return ApiClient(dio);
  }
  showResponseConsole(Response response) {
    if (response.data is Map<dynamic, dynamic>) {
      var data = Map<String, dynamic>.from(response.data);
      print(data);
    } else if (response.data is List<dynamic>) {
      var data = List.from(response.data);
      // ignore: avoid_print
      print("RESPONSE: $data");
    }
  }

}