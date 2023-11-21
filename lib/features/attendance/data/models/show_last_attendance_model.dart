
// To parse this JSON data, do
//
//     final showLastAttendanceModel = showLastAttendanceModelFromJson(jsonString);

import 'dart:convert';

ShowLastAttendanceModel showLastAttendanceModelFromJson(String str) => ShowLastAttendanceModel.fromJson(json.decode(str));

String showLastAttendanceModelToJson(ShowLastAttendanceModel data) => json.encode(data.toJson());

class ShowLastAttendanceModel {
  final bool status;
  final String errNum;
  final int msg;
  final ListClass list;

  ShowLastAttendanceModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.list,
  });

  factory ShowLastAttendanceModel.fromJson(Map<String, dynamic> json) => ShowLastAttendanceModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    list: ListClass.fromJson(json["list"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "list": list.toJson(),
  };
}

class ListClass {
  final int currentPage;
  final List<EmployeesData> employeesData;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<LinksInfo> linksInfo;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  ListClass({
    required this.currentPage,
    required this.employeesData,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.linksInfo,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    currentPage: json["current_page"],
    employeesData: List<EmployeesData>.from(json["data"].map((x) => EmployeesData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    linksInfo: List<LinksInfo>.from(json["links"].map((x) => LinksInfo.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "employeesData": List<dynamic>.from(employeesData.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "linksInfo": List<dynamic>.from(linksInfo.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class EmployeesData {
  final int id;
  final String employeeId;
  final DateTime date;
  final DateTime startTime;
  final dynamic endTime;
  final String overtime;
  final String status;
  final String locationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final EmployeeInfo employeeInfo;
  final LocationInfo locationInfo;

  EmployeesData({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.overtime,
    required this.status,
    required this.locationId,
    required this.createdAt,
    required this.updatedAt,
    required this.employeeInfo,
    required this.locationInfo,
  });

  factory EmployeesData.fromJson(Map<String, dynamic> json) => EmployeesData(
    id: json["id"],
    employeeId: json["employee_id"],
    date: DateTime.parse(json["date"]),
    startTime: DateTime.parse(json["start_time"]),
    endTime: json["end_time"],
    overtime: json["overtime"],
    status: json["status"],
    locationId: json["location_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    employeeInfo: EmployeeInfo.fromJson(json["employee"]),
    locationInfo: LocationInfo.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "start_time": startTime.toIso8601String(),
    "end_time": endTime,
    "overtime": overtime,
    "status": status,
    "location_id": locationId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "employeeInfo": employeeInfo.toJson(),
    "locationInfo": locationInfo.toJson(),
  };
}

class EmployeeInfo {
  final int id;
  final String name;
  final String mobile;
  final String password;
  final String img;
  final dynamic address;
  final dynamic startedDate;
  final String admin;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeInfo({
    required this.id,
    required this.name,
    required this.mobile,
    required this.password,
    required this.img,
    required this.address,
    required this.startedDate,
    required this.admin,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
    return EmployeeInfo(
      id: json["id"],
      name: json["name"],
      mobile: json["mobile"],
      password:json["password"],
      img: json["img"],
      address: json["address"],
      startedDate: json["started_date"],
      admin: json["admin"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "password": password,
    "img": img,
    "address": address,
    "started_date": startedDate,
    "admin": admin,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

// enum Img {
//   EMPTY,
//   THE_65289_F8941_C0_C_PNG
// }

// final imgValues = EnumValues({
//   "": Img.EMPTY,
//   "65289f8941c0c.png": Img.THE_65289_F8941_C0_C_PNG
// });

// enum EmployeeInfoName {
//   EMPTY,
//   HASSAN_SAYAD,
//   MOHAMED_SAAD
// }

// final employeeInfoNameValues = EnumValues({
//   "محمد علي": EmployeeInfoName.EMPTY,
//   "hassan sayad": EmployeeInfoName.HASSAN_SAYAD,
//   "mohamed saad": EmployeeInfoName.MOHAMED_SAAD
// });

// enum Password {
//   THE_2_Y_104_T5_BEEE_B6_QI_CP_H_BA_G_XG_BZ4_H_J_PL_PI_IE_A8_NO49_KD4_L6_VQ_QIM0_F_PU,
//   THE_2_Y_10_ID_UGI_NVM_WW_SN_RM_N39_G_TH7_EH_AM_NBF18_CAIWM_JGSC_FH_S_OZ_F2_V7_RO6_Y,
//   THE_2_Y_10_S_CQUP_S_QQ2_NC_TX_G_HI_Z_EIU_O_UQK_AD8_VTW_ZNE_F_FHD797_BC5_XB_ZRP0_K
// }

// final passwordValues = EnumValues({
//   "\u00242y\u002410\u00244T5beeeB6QI/cpH.baGXg.Bz4hJPlPIIeA8no49Kd4L6VQQim0FPu": Password.THE_2_Y_104_T5_BEEE_B6_QI_CP_H_BA_G_XG_BZ4_H_J_PL_PI_IE_A8_NO49_KD4_L6_VQ_QIM0_F_PU,
//   "\u00242y\u002410\u0024IdUGINvmWwSNRmN39GTh7ehAmNbf18caiwmJGSCFh/sOzF2V7Ro6y": Password.THE_2_Y_10_ID_UGI_NVM_WW_SN_RM_N39_G_TH7_EH_AM_NBF18_CAIWM_JGSC_FH_S_OZ_F2_V7_RO6_Y,
//   "\u00242y\u002410\u0024SCqupS.QQ2NCTxGHiZEiuOUqk/AD8vtwZNE.FFhd797Bc5XBZrp0K": Password.THE_2_Y_10_S_CQUP_S_QQ2_NC_TX_G_HI_Z_EIU_O_UQK_AD8_VTW_ZNE_F_FHD797_BC5_XB_ZRP0_K
// });

class LocationInfo {
  final int id;
  final String name;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  LocationInfo({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name":name,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

/*
enum LocationInfoName {
  EMPTY
}
*/

// final locationInfoNameValues = EnumValues({
//   "الموقع الأول": LocationInfoName.EMPTY
// });

class LinksInfo {
  final String? url;
  final String label;
  final bool active;

  LinksInfo({
    required this.url,
    required this.label,
    required this.active,
  });

  factory LinksInfo.fromJson(Map<String, dynamic> json) => LinksInfo(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}



// // To parse this JSON data, do
// //
// //     final showLastAttendanceModel = showLastAttendanceModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ShowLastAttendanceModel showLastAttendanceModelFromJson(String str) => ShowLastAttendanceModel.fromJson(json.decode(str));
//
// String showLastAttendanceModelToJson(ShowLastAttendanceModel data) => json.encode(data.toJson());
//
// class ShowLastAttendanceModel {
//   final bool status;
//   final String errNum;
//   final int msg;
//   final ListClass list;
//
//   ShowLastAttendanceModel({
//     required this.status,
//     required this.errNum,
//     required this.msg,
//     required this.list,
//   });
//
//   factory ShowLastAttendanceModel.fromJson(Map<String, dynamic> json) => ShowLastAttendanceModel(
//     status: json["status"],
//     errNum: json["errNum"],
//     msg: json["msg"],
//     list: ListClass.fromJson(json["list"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "errNum": errNum,
//     "msg": msg,
//     "list": list.toJson(),
//   };
// }
//
// class ListClass {
//   final int currentPage;
//   final List<EmployeesData> employeesData;
//   final String firstPageUrl;
//   final int from;
//   final int lastPage;
//   final String lastPageUrl;
//   final List<LinksInfo> linksInfo;
//   final dynamic nextPageUrl;
//   final String path;
//   final int perPage;
//   final dynamic prevPageUrl;
//   final int to;
//   final int total;
//
//   ListClass({
//     required this.currentPage,
//     required this.employeesData,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.linksInfo,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//
//   factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
//     currentPage: json["current_page"],
//     employeesData: List<EmployeesData>.from(json["data"].map((x) => EmployeesData.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     linksInfo: List<LinksInfo>.from(json["links"].map((x) => LinksInfo.fromJson(x))),
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "employeesData": List<dynamic>.from(employeesData.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "linksInfo": List<dynamic>.from(linksInfo.map((x) => x.toJson())),
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }
//
// class EmployeesData {
//   final int id;
//   final String employeeId;
//   final DateTime date;
//   final DateTime startTime;
//   final dynamic endTime;
//   final String overtime;
//   final String status;
//   final String locationId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final EmployeeInfo employeeInfo;
//   final LocationInfo locationInfo;
//
//   EmployeesData({
//     required this.id,
//     required this.employeeId,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//     required this.overtime,
//     required this.status,
//     required this.locationId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.employeeInfo,
//     required this.locationInfo,
//   });
//
//   factory EmployeesData.fromJson(Map<String, dynamic> json) => EmployeesData(
//     id: json["id"],
//     employeeId: json["employee_id"],
//     date: DateTime.parse(json["date"]),
//     startTime: DateTime.parse(json["start_time"]),
//     endTime: json["end_time"],
//     overtime: json["overtime"],
//     status: json["status"],
//     locationId: json["location_id"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     employeeInfo: EmployeeInfo.fromJson(json["employee"]),
//     locationInfo: LocationInfo.fromJson(json["location"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "employee_id": employeeId,
//     "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//     "start_time": startTime.toIso8601String(),
//     "end_time": endTime,
//     "overtime": overtime,
//     "status": status,
//     "location_id": locationId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "employeeInfo": employeeInfo.toJson(),
//     "locationInfo": locationInfo.toJson(),
//   };
// }
//
// class EmployeeInfo {
//   final int id;
//   final EmployeeInfoName name;
//   final String mobile;
//   final Password password;
//   final Img img;
//   final dynamic address;
//   final dynamic startedDate;
//   final String admin;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   EmployeeInfo({
//     required this.id,
//     required this.name,
//     required this.mobile,
//     required this.password,
//     required this.img,
//     required this.address,
//     required this.startedDate,
//     required this.admin,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
//     return EmployeeInfo(
//       id: json["id"],
//       name: employeeInfoNameValues.map[json["name"]]!,
//       mobile: json["mobile"],
//       password: passwordValues.map[json["password"]]!,
//       img: imgValues.map[json["img"]]!,
//       address: json["address"],
//       startedDate: json["started_date"],
//       admin: json["admin"],
//       status: json["status"],
//       createdAt: DateTime.parse(json["created_at"]),
//       updatedAt: DateTime.parse(json["updated_at"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": employeeInfoNameValues.reverse[name],
//     "mobile": mobile,
//     "password": passwordValues.reverse[password],
//     "img": imgValues.reverse[img],
//     "address": address,
//     "started_date": startedDate,
//     "admin": admin,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// enum Img {
//   EMPTY,
//   THE_65289_F8941_C0_C_PNG
// }
//
// final imgValues = EnumValues({
//   "": Img.EMPTY,
//   "65289f8941c0c.png": Img.THE_65289_F8941_C0_C_PNG
// });
//
// enum EmployeeInfoName {
//   EMPTY,
//   HASSAN_SAYAD,
//   MOHAMED_SAAD
// }
//
// final employeeInfoNameValues = EnumValues({
//   "محمد علي": EmployeeInfoName.EMPTY,
//   "hassan sayad": EmployeeInfoName.HASSAN_SAYAD,
//   "mohamed saad": EmployeeInfoName.MOHAMED_SAAD
// });
//
// enum Password {
//   THE_2_Y_104_T5_BEEE_B6_QI_CP_H_BA_G_XG_BZ4_H_J_PL_PI_IE_A8_NO49_KD4_L6_VQ_QIM0_F_PU,
//   THE_2_Y_10_ID_UGI_NVM_WW_SN_RM_N39_G_TH7_EH_AM_NBF18_CAIWM_JGSC_FH_S_OZ_F2_V7_RO6_Y,
//   THE_2_Y_10_S_CQUP_S_QQ2_NC_TX_G_HI_Z_EIU_O_UQK_AD8_VTW_ZNE_F_FHD797_BC5_XB_ZRP0_K
// }
//
// final passwordValues = EnumValues({
//   "\u00242y\u002410\u00244T5beeeB6QI/cpH.baGXg.Bz4hJPlPIIeA8no49Kd4L6VQQim0FPu": Password.THE_2_Y_104_T5_BEEE_B6_QI_CP_H_BA_G_XG_BZ4_H_J_PL_PI_IE_A8_NO49_KD4_L6_VQ_QIM0_F_PU,
//   "\u00242y\u002410\u0024IdUGINvmWwSNRmN39GTh7ehAmNbf18caiwmJGSCFh/sOzF2V7Ro6y": Password.THE_2_Y_10_ID_UGI_NVM_WW_SN_RM_N39_G_TH7_EH_AM_NBF18_CAIWM_JGSC_FH_S_OZ_F2_V7_RO6_Y,
//   "\u00242y\u002410\u0024SCqupS.QQ2NCTxGHiZEiuOUqk/AD8vtwZNE.FFhd797Bc5XBZrp0K": Password.THE_2_Y_10_S_CQUP_S_QQ2_NC_TX_G_HI_Z_EIU_O_UQK_AD8_VTW_ZNE_F_FHD797_BC5_XB_ZRP0_K
// });
//
// class LocationInfo {
//   final int id;
//   final LocationInfoName name;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   LocationInfo({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
//     id: json["id"],
//     name: locationInfoNameValues.map[json["name"]]!,
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": locationInfoNameValues.reverse[name],
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// enum LocationInfoName {
//   EMPTY
// }
//
// final locationInfoNameValues = EnumValues({
//   "الموقع الأول": LocationInfoName.EMPTY
// });
//
// class LinksInfo {
//   final String? url;
//   final String label;
//   final bool active;
//
//   LinksInfo({
//     required this.url,
//     required this.label,
//     required this.active,
//   });
//
//   factory LinksInfo.fromJson(Map<String, dynamic> json) => LinksInfo(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }


//=============================================================================
//=============================================================================
//=============================================================================
//=============================================================================
//=============================================================================
//=============================================================================

//
//
// // To parse this JSON data, do
// //
// //     final showLastAttendanceModel = showLastAttendanceModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ShowLastAttendanceModel showLastAttendanceModelFromJson(String str) => ShowLastAttendanceModel.fromJson(json.decode(str));
//
// String showLastAttendanceModelToJson(ShowLastAttendanceModel data) => json.encode(data.toJson());
//
// class ShowLastAttendanceModel {
//   final bool status;
//   final String errNum;
//   final int msg;
//   final ListClass list;
//
//   ShowLastAttendanceModel({
//     required this.status,
//     required this.errNum,
//     required this.msg,
//     required this.list,
//   });
//
//   factory ShowLastAttendanceModel.fromJson(Map<String, dynamic> json) => ShowLastAttendanceModel(
//     status: json["status"],
//     errNum: json["errNum"],
//     msg: json["msg"],
//     list: ListClass.fromJson(json["list"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "errNum": errNum,
//     "msg": msg,
//     "list": list.toJson(),
//   };
// }
//
// class ListClass {
//   final int currentPage;
//   final List<EmployeesData> employeesData;
//   final String firstPageUrl;
//   final int from;
//   final int lastPage;
//   final String lastPageUrl;
//   final List<LinksInfo>? linksInfo;
//   final dynamic nextPageUrl;
//   final String path;
//   final int perPage;
//   final dynamic prevPageUrl;
//   final int to;
//   final int total;
//
//   ListClass({
//     required this.currentPage,
//     required this.employeesData,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//      this.linksInfo,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//
//   factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
//     currentPage: json["current_page"],
//     employeesData: List<EmployeesData>.from(json["data"].map((x) => EmployeesData.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     linksInfo: json["links"] == null ? [] : List<LinksInfo>.from(json["links"]!.map((x) => LinksInfo.fromJson(x))),
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "employeesData": List<dynamic>.from(employeesData.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "linksInfo": linksInfo == null ? [] : List<dynamic>.from(linksInfo!.map((x) => x.toJson())),
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }
//
// class EmployeesData {
//   final int id;
//   final String employeeId;
//   final DateTime date;
//   final DateTime startTime;
//   final dynamic endTime;
//   final String overtime;
//   final String status;
//   final String locationId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final EmployeeInfo employeeInfo;
//   final LocationInfo locationInfo;
//
//   EmployeesData({
//     required this.id,
//     required this.employeeId,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//     required this.overtime,
//     required this.status,
//     required this.locationId,
//      this.createdAt,
//      this.updatedAt,
//      required  this.employeeInfo,
//       required this.locationInfo,
//   });
//
//   factory EmployeesData.fromJson(Map<String, dynamic> json) => EmployeesData(
//     id: json["id"],
//     employeeId: json["employee_id"],
//     date: DateTime.parse(json["date"]),
//     startTime: DateTime.parse(json["start_time"]),
//     endTime: json["end_time"],
//     overtime: json["overtime"],
//     status: json["status"],
//     locationId: json["location_id"],
//     createdAt: (json["created_at"]==null)?DateTime(0):DateTime.parse(json["created_at"]),
//     updatedAt: (json["updated_at"]==null)?DateTime(0):DateTime.parse(json["updated_at"]),
//     //employeeInfo: json["employee"] == null ? null : EmployeeInfo.fromJson(json["employee"]),
//     employeeInfo: EmployeeInfo.fromJson(json["employee"]),
//     locationInfo: LocationInfo.fromJson(json["location"]),
//     //locationInfo: json["location"] == null ? null : LocationInfo.fromJson(json["location"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "employee_id": employeeId,
//     "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//     "start_time": startTime.toIso8601String(),
//     "end_time": endTime,
//     "overtime": overtime,
//     "status": status,
//     "location_id": locationId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "employeeInfo": employeeInfo!.toJson(),
//     "locationInfo": locationInfo!.toJson(),
//   };
// }
//
// class EmployeeInfo {
//   final int? id;
//   final String? name;
//   final String? mobile;
//   final String? password;
//   final String? img;
//   final dynamic address;
//   final dynamic startedDate;
//   final String? admin;
//   final String? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   EmployeeInfo({
//      this.id,
//      this.name,
//      this.mobile,
//      this.password,
//      this.img,
//      this.address,
//      this.startedDate,
//      this.admin,
//      this.status,
//      this.createdAt,
//      this.updatedAt,
//   });
//
//   factory EmployeeInfo.fromJson(Map<String, dynamic>? json) => EmployeeInfo(
//     id: json?["id"],
//     name: json?["name"],
//     mobile: json?["mobile"],
//     password: json?["password"],
//     img: json?["img"],
//     address: json?["address"],
//     startedDate: json?["started_date"],
//     admin: json?["admin"],
//     status: json?["status"],
//     createdAt: DateTime.parse(json?["created_at"]),
//     updatedAt: DateTime.parse(json?["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "mobile": mobile,
//     "password": password,
//     "img": img,
//     "address": address,
//     "started_date": startedDate,
//     "admin": admin,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
// class LocationInfo {
//   final int id;
//   final String name;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   LocationInfo({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
//     id: json["id"],
//     name: json["name"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class LinksInfo {
//   final String? url;
//   final String label;
//   final bool active;
//
//   LinksInfo({
//     required this.url,
//     required this.label,
//     required this.active,
//   });
//
//   factory LinksInfo.fromJson(Map<String, dynamic> json) => LinksInfo(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }
//
