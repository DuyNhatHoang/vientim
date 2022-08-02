// ignore: file_names
import 'package:vkhealth/app/models/response_models/booking/booking_response.dart';

class BookingHistory {
  List<BookingResponseData> data;
  BookingHistory({this.data});

  BookingHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookingResponseData>[];
      json['data'].forEach((v) { data.add(BookingResponseData.fromJson(v)); });
    }
  }

}
