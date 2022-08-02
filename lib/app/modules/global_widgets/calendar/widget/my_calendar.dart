import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/ui.dart';
import '../helper/datetime_caculator.dart';

GlobalKey<_MyCalendarState> calendarKey = GlobalKey<_MyCalendarState>();

class MyCalendar extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onChange;
  final List<DateTime> availableDates;

  const MyCalendar(
      {Key key, this.initialDate, this.onChange, this.availableDates})
      : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  Size size;
  DateTime selectedDate;
  List<List<DateTime>> listDateTime;
  List<String> dateTitleName = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
  DateTime initialDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialDate = widget.initialDate;
    // selectedDate = initialDate;
    try{
      selectedDate = widget.availableDates.first;
    } catch(e){
      selectedDate = DateTime(2000,1,1);
    }
    listDateTime = getDateTimeForCalendar(initialDate);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(size.width * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(DateTime.now().year - 1, 1, 1),
                      maxTime: DateTime(DateTime.now().year + 1, 1, 1),
                      onChanged: (date) {},
                      onConfirm: (date) {
                        setState(() {
                          initialDate = date;
                          listDateTime = getDateTimeForCalendar(initialDate);
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.vi);
                },
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.015),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(size.width * 0.05),
                  //     color: Colors.blue.withOpacity(.4)
                  // ),
                  child: Row(
                    children: [
                      Text(
                        "Tháng ${initialDate.month}/${initialDate.year}",
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.04,
                            color: Colors.black),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: size.width * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        initialDate = DateTime(
                            initialDate.year, initialDate.month - 1, 1);
                        listDateTime = getDateTimeForCalendar(initialDate);
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: size.width * 0.05,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        initialDate = DateTime(
                            initialDate.year, initialDate.month + 1, 1);
                        listDateTime = getDateTimeForCalendar(initialDate);
                      });
                    },
                    child: Icon(Icons.arrow_forward_ios_outlined,
                        size: size.width * 0.05, color: Colors.blue.shade700),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dateTitleName
                      .map((e) => SizedBox(
                            width: (size.width - size.width * 0.02) / 8,
                            child: Center(
                              child: InkWell(
                                child: Text(
                                  e,
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.grey,
                                      fontSize: size.width * 0.045,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: listDateTime.map((e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: e.map((e) {
                        return InkWell(
                          onTap: () {
                            if(isAvailableDate(e)){
                              setState(() {
                                selectedDate = e;
                              });
                              widget.onChange(selectedDate);
                            } else {
                              Get.showSnackbar(Ui.RemindSnackBar( message: "Không có dịch vụ trong ngày được chọn"));
                            }

                          },
                          child: Container(
                            decoration: isTheSameDate(e, selectedDate)
                                ? BoxDecoration(
                                    color: Ui.parseColor("#1A75FF"),
                                    shape: BoxShape.circle,
                                  )
                                : null,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.01),
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.005),
                            width: (size.width - size.width * 0.02) / 8,
                            child: Center(
                              child: Text(
                                e == null ? "" : e.day.toString(),
                                style: GoogleFonts.sourceSansPro(
                                    color: isTheSameDate(e, selectedDate)
                                        ? Colors.white
                                        : isAvailableDate(e) ? Colors.green : Colors.grey.withOpacity(.2),
                                    fontSize: size.width * 0.047,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isAvailableDate(DateTime currentDate) {
    try {
      if (widget.availableDates.contains(currentDate)) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  bool isTheSameDate(DateTime d1, DateTime d2) {
    if (d1 == null || d2 == null) {
      return false;
    }
    return (d1.day == d2.day && d1.month == d2.month) ||
        (d1.day == d2.day && d1.month == d2.month);
  }
}
