import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/request_models/booking/bookinghis_query.dart';
import '../../../models/response_models/booking/booking-history.dart';
import '../../../repositories/booking_repository.dart';

class HomeController extends GetxController{
  BookingRepository _bookingRepository;
  Rx<BookingHistory> history = BookingHistory(
    data: []
  ).obs;

  HomeController(){
    _bookingRepository = BookingRepository();
  }

  Future<void> getHistory() async {
    try{
      var result = await _bookingRepository.getBookingHistory(BookingHisQuery(
          from: DateTime.now().toIso8601String(),
          to: DateTime.now().add(const Duration(days: 7)).toIso8601String()
      ));
      history.value = result;
    } catch(e){
      Get.showSnackbar(Ui.RemindSnackBar( message: "Lấy thông tin thất bại"));
    } finally {
      
    }
  }



}