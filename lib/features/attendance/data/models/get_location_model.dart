// To parse this JSON data, do
//
//     final getLocationsModel = getLocationsModelFromJson(jsonString);

import 'dart:convert';

GetLocationsModel getLocationsModelFromJson(String str) => GetLocationsModel.fromJson(json.decode(str));

String getLocationsModelToJson(GetLocationsModel data) => json.encode(data.toJson());

class GetLocationsModel {
  final bool status;
  final String errNum;
  final int msg;
  final Locations locations;

  GetLocationsModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.locations,
  });

  factory GetLocationsModel.fromJson(Map<String, dynamic> json) => GetLocationsModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    locations: Locations.fromJson(json["locations"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "locations": locations.toJson(),
  };
}

class Locations {
  final int currentPage;
  final List<OneLocation> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<LinkLocation> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  Locations({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    currentPage: json["current_page"],
    data: List<OneLocation>.from(json["data"].map((x) => OneLocation.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<LinkLocation>.from(json["links"].map((x) => LinkLocation.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class OneLocation {
  final int id;
  final String name;
  final List<Employee> employees;

  OneLocation({
    required this.id,
    required this.name,
    required this.employees,
  });

  factory OneLocation.fromJson(Map<String, dynamic> json) => OneLocation(
    id: json["id"],
    name: json["name"],
    employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
  };
}

class Employee {
  final int id;
  final String name;
  final String mobile;
  final PivotLocation pivot;

  Employee({
    required this.id,
    required this.name,
    required this.mobile,
    required this.pivot,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    pivot: PivotLocation.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "pivot": pivot.toJson(),
  };
}

class PivotLocation {
  final String locationId;
  final String employeeId;

  PivotLocation({
    required this.locationId,
    required this.employeeId,
  });

  factory PivotLocation.fromJson(Map<String, dynamic> json) => PivotLocation(
    locationId: json["location_id"],
    employeeId: json["employee_id"],
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "employee_id": employeeId,
  };
}

class LinkLocation {
  final String? url;
  final String label;
  final bool active;

  LinkLocation({
    required this.url,
    required this.label,
    required this.active,
  });

  factory LinkLocation.fromJson(Map<String, dynamic> json) => LinkLocation(
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
