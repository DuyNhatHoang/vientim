class Doctors {
  int pageIndex;
  int pageSize;
  int totalPage;
  int totalSize;
  List<Doctor> data;

  Doctors(
      {this.pageIndex,
        this.pageSize,
        this.totalPage,
        this.totalSize,
        this.data});

  Doctors.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    totalSize = json['totalSize'];
    if (json['data'] != null) {
      data = <Doctor>[];
      json['data'].forEach((v) {
        data.add(Doctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalPage'] = totalPage;
    data['totalSize'] = totalSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  String id;
  bool isDeleted;
  List<Unit> unit;
  String code;
  String fullName;
  String identityCard;
  String title;
  String academicTitle;
  bool gender;
  String email;
  String phone;
  String value;

  Doctor(
      {this.id,
        this.isDeleted,
        this.unit,
        this.code,
        this.fullName,
        this.identityCard,
        this.title,
        this.academicTitle,
        this.gender,
        this.email,
        this.phone});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDeleted = json['isDeleted'];
    if (json['unit'] != null) {
      unit = <Unit>[];
      json['unit'].forEach((v) {
        unit.add(Unit.fromJson(v));
      });
    }
    code = json['code'];
    fullName = json['fullName'];
    identityCard = json['identityCard'];
    title = json['title'];
    academicTitle = json['academicTitle'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    if (unit != null) {
      data['unit'] = unit.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['fullName'] = fullName;
    data['identityCard'] = identityCard;
    data['title'] = title;
    data['academicTitle'] = academicTitle;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class Unit {
  String dateCreated;
  String dateUpdated;
  String logo;
  bool isDeleted;
  bool isTestingFacility;
  bool isPrEPFacility;
  bool isARTFacility;
  String parentId;
  String id;
  String username;
  String name;
  String unitTypeId;
  String address;
  String province;
  String district;
  String ward;
  String website;
  String phone;
  String email;
  String introduction;

  Unit(
      {this.dateCreated,
        this.dateUpdated,
        this.logo,
        this.isDeleted,
        this.isTestingFacility,
        this.isPrEPFacility,
        this.isARTFacility,
        this.parentId,
        this.id,
        this.username,
        this.name,
        this.unitTypeId,
        this.address,
        this.province,
        this.district,
        this.ward,
        this.website,
        this.phone,
        this.email,
        this.introduction});

  Unit.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    logo = json['logo'];
    isDeleted = json['isDeleted'];
    isTestingFacility = json['isTestingFacility'];
    isPrEPFacility = json['isPrEPFacility'];
    isARTFacility = json['isARTFacility'];
    parentId = json['parentId'];
    id = json['id'];
    username = json['username'];
    name = json['name'];
    unitTypeId = json['unitTypeId'];
    address = json['address'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    website = json['website'];
    phone = json['phone'];
    email = json['email'];
    introduction = json['introduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['logo'] = logo;
    data['isDeleted'] = isDeleted;
    data['isTestingFacility'] = isTestingFacility;
    data['isPrEPFacility'] = isPrEPFacility;
    data['isARTFacility'] = isARTFacility;
    data['parentId'] = parentId;
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['unitTypeId'] = unitTypeId;
    data['address'] = address;
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    data['website'] = website;
    data['phone'] = phone;
    data['email'] = email;
    data['introduction'] = introduction;
    return data;
  }
}