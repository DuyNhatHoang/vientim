class AllRelation {
  String id;
  String fullname;
  String username;
  bool gender;
  String dateOfBirth;
  String insurranceCode;
  String insurranceDate;
  String phoneNumber;
  String email;
  String vaccinationCode;
  String identityCard;
  String address;
  String province;
  String provinceCode;
  String district;
  String ward;
  String relationProfileId;
  String passportNumber;
  String nation;
  bool isDeleted;
  int status;
  String externalId;

  AllRelation(
      {this.id,
        this.fullname,
        this.username,
        this.gender,
        this.dateOfBirth,
        this.insurranceCode,
        this.insurranceDate,
        this.phoneNumber,
        this.email,
        this.vaccinationCode,
        this.identityCard,
        this.address,
        this.province,
        this.district,
        this.ward,
        this.relationProfileId,
        this.passportNumber,
        this.nation,
        this.isDeleted,
        this.status,
        this.externalId});

  AllRelation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    insurranceCode = json['insurranceCode'];
    insurranceDate = json['insurranceDate'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    vaccinationCode = json['vaccinationCode'];
    identityCard = json['identityCard'];
    address = json['address'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    relationProfileId = json['relationProfileId'];
    passportNumber = json['passportNumber'];
    nation = json['nation'];
    isDeleted = json['isDeleted'];
    status = json['status'];
    externalId = json['externalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['username'] = username;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['birthDate'] = dateOfBirth;
    data['insurranceCode'] = insurranceCode;
    data['insurranceDate'] = insurranceDate;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['vaccinationCode'] = vaccinationCode;
    data['identityCard'] = identityCard;
    data['address'] = address;
    data['province'] = province;
    data['provinceCode'] = province;
    data['districtCode'] = province;
    data['provinceCode'] = district;
    data['wardCode'] = ward;
    data['district'] = district;
    data['ward'] = ward;
    data['relationProfileId'] = relationProfileId;
    data['passportNumber'] = passportNumber;
    data['nation'] = nation;
    data['isDeleted'] = isDeleted;
    data['status'] = status;
    data['externalId'] = externalId;
    return data;
  }
}