class Profile {
  String id;
  String fullname;
  String username;
  bool gender;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String vaccinationCode;
  String identityCard;
  String address;
  String province;
  String district;
  String ward;
  String passportNumber;
  String insurranceDate;
  String nation;
  String insurranceCode;
  bool isDeleted;
  int status;

  Profile(
      {this.id,
        this.fullname,
        this.username,
        this.insurranceDate,
        this.insurranceCode,
        this.gender,
        this.dateOfBirth,
        this.phoneNumber,
        this.email,
        this.vaccinationCode,
        this.identityCard,
        this.address,
        this.province,
        this.district,
        this.ward,
        this.passportNumber,
        this.nation,
        this.isDeleted,
        this.status,});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    insurranceCode = json['insurranceCode'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    vaccinationCode = json['vaccinationCode'];
    identityCard = json['identityCard'];
    insurranceDate = json['insurranceDate'];
    address = json['address'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    passportNumber = json['passportNumber'];
    nation = json['nation'];
    isDeleted = json['isDeleted'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['insurranceCode'] = insurranceCode;
    data['insurranceDate'] = insurranceDate;
    data['fullname'] = fullname;
    data['username'] = username;
    data['address'] = address;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['vaccinationCode'] = vaccinationCode;
    data['identityCard'] = identityCard;
    data['address'] = address;
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    data['passportNumber'] = passportNumber;
    data['nation'] = nation;
    data['isDeleted'] = isDeleted;
    data['status'] = status;
    return data;
  }
}