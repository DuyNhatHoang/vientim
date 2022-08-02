import 'package:vkhealth/app/models/request_models/booking/booking.dart';

import 'doctor.dart';
import 'service_model.dart';

class DoctorWorkingCalendar {
  String id;
  String dateCreated;
  String dateUpdated;
  int bookingBeforeDate;
  int bookingAfterDate;
  String description;
  String fromDate;
  String toDate;
  String fromTo;
  Doctor doctor;
  Room room;
  List<Services> services;
  List<ServiceModel> serviceModel;
  int status;

  DoctorWorkingCalendar(
      {this.id,
      this.dateCreated,
      this.dateUpdated,
      this.bookingBeforeDate,
      this.bookingAfterDate,
      this.description,
      this.fromDate,
      this.toDate,
      this.fromTo,
      this.doctor,
      this.room,
      this.services,
      this.status});

  DoctorWorkingCalendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    bookingBeforeDate = json['bookingBeforeDate'];
    bookingAfterDate = json['bookingAfterDate'];
    description = json['description'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    fromTo = json['fromTo'];
    doctor =
        json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services.add(Services.fromJson(v));
      });
    }
    if(services != null){
      serviceModel = services.map((e) => e.service).toList();
    }

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['bookingBeforeDate'] = bookingBeforeDate;
    data['bookingAfterDate'] = bookingAfterDate;
    data['description'] = description;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['fromTo'] = fromTo;
    if (doctor != null) {
      data['doctor'] = doctor.toJson();
    }
    if (room != null) {
      data['room'] = room.toJson();
    }
    if (services != null) {
      data['services'] = services.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}


class Services {
  ServiceModel service;

  Services({this.service});

  Services.fromJson(Map<String, dynamic> json) {
    service =
        json['service'] != null ? ServiceModel.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service'] = service.toJson();
    }
    return data;
  }
}




