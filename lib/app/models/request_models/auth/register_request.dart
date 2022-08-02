class RegisterRequest {
  String username;
  String password;
  String confirmPass;
  String email;
  String phoneNumber;
  String fullName;
  bool isElasticSynced;
  String groupName;
  bool onlyUsername;

  RegisterRequest(
      {this.username,
        this.password,
        this.email,
        this.phoneNumber,
        this.fullName,
        this.isElasticSynced= true,
        this.groupName,
        this.onlyUsername = true});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    isElasticSynced = json['isElasticSynced'];
    groupName = json['groupName'];
    onlyUsername = json['onlyUsername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = phoneNumber;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['isElasticSynced'] = isElasticSynced;
    data['onlyUsername'] = onlyUsername;
    return data;
  }
}