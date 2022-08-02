
import 'package:vkhealth/app/models/request_models/user/all_relation.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';

import '../../response_models/booking/date_for_service.dart';
import '../../response_models/booking/interval_for_date.dart';

class BookingRequest {
  Intervals interval;
  Unit unit;
  Doctor doctor;
  Room room;
  InjectionObject injectionObject;
  ServiceModel service;
  AllRelation customer;
  String note;
  String date;
  String bookedByUser;
  ExitInformation exitInformation;
  TestingContent testingContent;
  TestingContent consultingContent;

  BookingRequest({this.interval, this.unit, this.doctor, this.room, this.injectionObject, this.service, this.customer,  this.note, this.date, this.bookedByUser, this.exitInformation,  this.testingContent});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    interval = json['interval'] != null ? Intervals.fromJson(json['interval']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    injectionObject = json['injectionObject'] != null ? InjectionObject.fromJson(json['injectionObject']) : null;
    service = json['service'] != null ? ServiceModel.fromJson(json['service']) : null;
    customer = json['customer'] != null ? AllRelation.fromJson(json['customer']) : null;
    note = json['note'];
    date = json['date'];
    bookedByUser = json['bookedByUser'];
    exitInformation = json['exitInformation'] != null ? ExitInformation.fromJson(json['exitInformation']) : null;
    testingContent = json['testingContent'] != null ? TestingContent.fromJson(json['testingContent']) : null;
    // consultingContent = json['consultingContent'] != null ? TestingContent.fromJson(json['consultingContent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (interval != null) {
      data['interval'] = interval.toJson();
    }
    if (unit != null) {
      data['unit'] = unit.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor.toJson();
    }
    if (room != null) {
      data['room'] = room.toJson();
    }
    if (injectionObject != null) {
      data['injectionObject'] = injectionObject.toJson();
    }
    if (service != null) {
      data['service'] = service.toJson();
    }
    if (customer != null) {
      data['customer'] = customer.toJson();
    }
    data['note'] = note;
    data['date'] = date;
    data['bookedByUser'] = bookedByUser;
    if (exitInformation != null) {
      data['exitInformation'] = exitInformation.toJson();
    }
    if (testingContent != null) {
      data['testingContent'] = testingContent.toJson();
    }
    data['consultingContent'] =<String, dynamic>{};
    return data;
  }
}
class Unit {
  String id;
  String name;
  String information;
  String address;
  String username;
  String provinceCode;
  String districtCode;
  String wardCode;

  Unit({this.id, this.name, this.information, this.address, this.username, this.provinceCode, this.districtCode, this.wardCode});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    information = json['information'];
    address = json['address'];
    username = json['username'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    wardCode = json['wardCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['information'] = information;
    data['address'] = address;
    data['username'] = username;
    data['provinceCode'] = provinceCode;
    data['districtCode'] = districtCode;
    data['wardCode'] = wardCode;
    return data;
  }
}

class Room {
  String id;
  String description;
  String name;

  Room({this.id, this.description, this.name});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['name'] = name;
    return data;
  }
}

class InjectionObject {
  String id;
  String name;

  InjectionObject({this.id, this.name});

  InjectionObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}



class ExitInformation {
  String destination;
  String exitingDate;
  String entryingDate;

  ExitInformation({this.destination, this.exitingDate, this.entryingDate});

  ExitInformation.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    exitingDate = json['exitingDate'];
    entryingDate = json['entryingDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destination'] = destination;
    data['exitingDate'] = exitingDate;
    data['entryingDate'] = entryingDate;
    return data;
  }
}

class TestingContent {
  String typeTesting;
  int quantity;
  bool isReceived;
  bool isPickUpAtTheFacility;
  String receivingAddress;
  String provinceCode;
  String districtCode;
  String wardCode;
  String receiver;
  String recipientPhoneNumber;
  String content;
  String result;
  String note;

  TestingContent({this.typeTesting, this.quantity, this.isReceived, this.isPickUpAtTheFacility, this.receivingAddress, this.provinceCode, this.districtCode, this.wardCode, this.receiver, this.recipientPhoneNumber, this.content, this.result, this.note});

  TestingContent.fromJson(Map<String, dynamic> json) {
    typeTesting = json['typeTesting'];
    quantity = json['quantity'];
    isReceived = json['isReceived'];
    isPickUpAtTheFacility = json['isPickUpAtTheFacility'];
    receivingAddress = json['receivingAddress'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    wardCode = json['wardCode'];
    receiver = json['receiver'];
    recipientPhoneNumber = json['recipientPhoneNumber'];
    content = json['content'];
    result = json['result'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeTesting'] = typeTesting;
    data['quantity'] = quantity;
    data['isReceived'] = isReceived;
    data['isPickUpAtTheFacility'] = isPickUpAtTheFacility;
    data['receivingAddress'] = receivingAddress;
    data['provinceCode'] = provinceCode;
    data['districtCode'] = districtCode;
    data['wardCode'] = wardCode;
    data['receiver'] = receiver;
    data['recipientPhoneNumber'] = recipientPhoneNumber;
    data['content'] = content;
    data['result'] = result;
    data['note'] = note;
    return data;
  }
}

