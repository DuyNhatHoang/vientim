class UserInfoSwagger {
  Data data;
  bool succeed;

  UserInfoSwagger({this.data, this.succeed});

  UserInfoSwagger.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    succeed = json['succeed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['succeed'] = succeed;
    return data;
  }
}

class Data {
  UserInfo userInfo;
  // List<Null> permissions;

  Data({this.userInfo});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? UserInfo.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['userInfo'] = userInfo.toJson();
    }
    return data;
  }
}

class UserInfo {
  String id;
  String username;
  String email;
  String phoneNumber;
  String fullName;
  bool isConfirmed;
  bool isDisabled;
  bool isElasticSynced;

  UserInfo(
      {this.id,
        this.username,
        this.email,
        this.phoneNumber,
        this.fullName,
        this.isConfirmed,
        this.isDisabled,
        this.isElasticSynced});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    isConfirmed = json['isConfirmed'];
    isDisabled = json['isDisabled'];
    isElasticSynced = json['isElasticSynced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['isConfirmed'] = isConfirmed;
    data['isDisabled'] = isDisabled;
    data['isElasticSynced'] = isElasticSynced;
    return data;
  }
}