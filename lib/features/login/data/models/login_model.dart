// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String errNum;
  String msg;
  User user;

  LoginModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  dynamic email;
  String mobile;
  String image;
  int verify;
  String apiToken;
  String type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.image,
    required this.verify,
    required this.apiToken,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    image: json["image"],
    verify: json["verify"],
    apiToken: json["api_token"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "image": image,
    "verify": verify,
    "api_token": apiToken,
    "type": type,
  };
}
