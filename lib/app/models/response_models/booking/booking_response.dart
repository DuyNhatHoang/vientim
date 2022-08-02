import '../../request_models/booking/booking.dart';

class BookingResponse {
  BookingResponseData data;

  BookingResponse({this.data,});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = BookingResponseData.fromJson(json['data']);
    }
  }
}

class BookingResponseData {
  String id;
  int status;
  String dateBooked;
  bool hasFile;
  int transferStatus;
  int paymenStatus;
  int paymentStatus;
  List<PaymentLogs> paymentLogs;
  Interval interval;
  Unit unit;
  Doctor doctor;
  Room room;
  Service service;
  Customer customer;
  String note;
  String date;
  String bookedByUser;
  TestingContent testingContent;

  BookingResponseData({this.id, this.status, this.dateBooked, this.hasFile, this.transferStatus, this.paymenStatus, this.paymentStatus, this.paymentLogs, this.interval, this.unit, this.doctor, this.room, this.service, this.customer, this.bookedByUser, this.testingContent});

  BookingResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    dateBooked = json['dateBooked'];
    hasFile = json['hasFile'];
    transferStatus = json['transferStatus'];
    paymenStatus = json['paymenStatus'];
    paymentStatus = json['paymentStatus'];
    if (json['paymentLogs'] != null) {
      paymentLogs = <PaymentLogs>[];
      json['paymentLogs'].forEach((v) { paymentLogs.add(PaymentLogs.fromJson(v)); });
    }
    interval = json['interval'] != null ? Interval.fromJson(json['interval']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    note = json['note'];
    date = json['date'];
    bookedByUser = json['bookedByUser'];
    testingContent = json['testingContent'] != null ? TestingContent.fromJson(json['testingContent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['dateBooked'] = dateBooked;
    data['hasFile'] = hasFile;
    data['transferStatus'] = transferStatus;
    data['paymenStatus'] = paymenStatus;
    data['paymentStatus'] = paymentStatus;
    if (paymentLogs != null) {
      data['paymentLogs'] = paymentLogs.map((v) => v.toJson()).toList();
    }
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
    if (service != null) {
      data['service'] = service.toJson();
    }
    if (customer != null) {
      data['customer'] = customer.toJson();
    }
    data['date'] = date;
    data['bookedByUser'] = bookedByUser;
    if (testingContent != null) {
      data['testingContent'] = testingContent.toJson();
    }
    return data;
  }
}

class PaymentLogs {
  String id;
  int status;
  String content;
  String username;
  String dateCreate;
  String dateUpdate;

  PaymentLogs({this.id, this.status, this.content, this.username, this.dateCreate, this.dateUpdate});

  PaymentLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    content = json['content'];
    username = json['username'];
    dateCreate = json['dateCreate'];
    dateUpdate = json['dateUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['content'] = content;
    data['username'] = username;
    data['dateCreate'] = dateCreate;
    data['dateUpdate'] = dateUpdate;
    return data;
  }
}

class Interval {
  String id;
  String from;
  String to;
  int numId;

  Interval({this.id, this.from, this.to, this.numId});

  Interval.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    numId = json['numId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['numId'] = numId;
    return data;
  }
}


class Doctor {
  String id;
  String fullname;

  Doctor({this.id, this.fullname});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    return data;
  }
}

class Room {
  String id;
  String name;

  Room({this.id, this.name});

  Room.fromJson(Map<String, dynamic> json) {
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

class Service {
  String id;
  String name;
  int price;

  Service({this.id, this.name, this.price});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class Customer {
  String id;
  String fullname;
  String username;
  String phone;
  String email;
  String address;
  String birthDate;
  int birthDateY;
  int birthDateM;
  int birthDateD;
  bool gender;
  String provinceCode;
  String districtCode;
  String insurranceCode;
  String wardCode;
  Customer({this.id, this.fullname, this.username, this.phone, this.email, this.address, this.birthDate, this.birthDateY, this.birthDateM, this.birthDateD, this.gender, this.provinceCode, this.districtCode, this.insurranceCode});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    birthDate = json['birthDate'];
    birthDateY = json['birthDateY'];
    birthDateM = json['birthDateM'];
    birthDateD = json['birthDateD'];
    gender = json['gender'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    insurranceCode = json['insurranceCode'];
    wardCode = json['wardCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['username'] = username;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['birthDate'] = birthDate;
    data['birthDateY'] = birthDateY;
    data['birthDateM'] = birthDateM;
    data['birthDateD'] = birthDateD;
    data['gender'] = gender;
    data['provinceCode'] = provinceCode;
    data['districtCode'] = districtCode;
    data['insurranceCode'] = insurranceCode;
    return data;
  }
}
