// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
  final bool status;
  final String errNum;
  final int msg;
  final String user;

  AttendanceModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.user,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "user": user,
  };
}
