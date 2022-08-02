import 'package:vkhealth/app/models/parents/model.dart';

class User extends Model{
  String token;
  String tokenType;
  String userId;
  String username;
  int expiresIn;
  String dateExpired;

  bool auth;

  User(
      {this.token,
        this.tokenType,
        this.userId,
        this.username,
        this.dateExpired,
        this.expiresIn,
      });

  User.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    tokenType = json['token_type'];
    userId = json['userId'];
    dateExpired = json['dateExpired'];
    username = json['username'];
    expiresIn = json['expires_in'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = token;
    data['token_type'] = tokenType;
    data['userId'] = userId;
    data['username'] = username;
    data['expires_in'] = expiresIn;
    data['dateExpired'] = dateExpired;
    return data;
  }
}