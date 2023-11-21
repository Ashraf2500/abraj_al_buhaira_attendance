// To parse this JSON data, do
//
//     final getEmployeesModel = getEmployeesModelFromJson(jsonString);

import 'dart:convert';

GetEmployeesModel getEmployeesModelFromJson(String str) => GetEmployeesModel.fromJson(json.decode(str));

String getEmployeesModelToJson(GetEmployeesModel data) => json.encode(data.toJson());

class GetEmployeesModel {
  final bool status;
  final String errNum;
  final int msg;
  final Employees employees;

  GetEmployeesModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.employees,
  });

  factory GetEmployeesModel.fromJson(Map<String, dynamic> json) => GetEmployeesModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    employees: Employees.fromJson(json["employees"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "employees": employees.toJson(),
  };
}

class Employees {
  final int currentPage;
  final List<OneEmployee> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  Employees({
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

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
    currentPage: json["current_page"],
    data: List<OneEmployee>.from(json["data"].map((x) => OneEmployee.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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

class OneEmployee {
  final int id;
  final String name;
  final String mobile;
  final List<Location> locations;

  OneEmployee({
    required this.id,
    required this.name,
    required this.mobile,
    required this.locations,
  });

  factory OneEmployee.fromJson(Map<String, dynamic> json) => OneEmployee(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
  };
}

class Location {
  final int id;
  final String name;
  final Pivot pivot;

  Location({
    required this.id,
    required this.name,
    required this.pivot,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  final String employeeId;
  final String locationId;

  Pivot({
    required this.employeeId,
    required this.locationId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    employeeId: json["employee_id"],
    locationId: json["location_id"],
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "location_id": locationId,
  };
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
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
