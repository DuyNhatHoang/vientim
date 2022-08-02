import 'package:vkhealth/app/models/request_models/booking/booking.dart';

class DateForService {
  String id;
  String date;
  String time;
  int status;
  Schedules schedules;
  Doctor doctor;
  Room room;
  String hospitalName;
  // List<Service> service;

  DateForService(
      {this.id,
        this.date,
        this.time,
        this.status,
        this.schedules,
        this.doctor,
        this.room,
        this.hospitalName,
        // this.service
      });

  DateForService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    schedules = json['schedules'] != null
        ? Schedules.fromJson(json['schedules'])
        : null;
    doctor =
    json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    hospitalName = json['hospitalName'];
    // if (json['service'] != null) {
    //   service = <Service>[];
    //   json['service'].forEach((v) {
    //     service!.add(new Service.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    if (schedules != null) {
      data['schedules'] = schedules.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor.toJson();
    }
    if (room != null) {
      data['room'] = room.toJson();
    }
    data['hospitalName'] = hospitalName;
    // if (this.service != null) {
    //   data['service'] = this.service!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Schedules {
  String from;
  String to;

  Schedules({this.from, this.to});

  Schedules.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}

class Doctor {
  String id;
  String description;
  String fullName;

  Doctor({this.id, this.description, this.fullName});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    fullName = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullName;
    data['description'] = description;
    return data;
  }
}