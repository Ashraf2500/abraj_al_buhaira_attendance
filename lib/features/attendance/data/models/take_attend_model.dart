// EmployeeAttendModel employee = EmployeeAttendModel(
//     Date: DateTime.now(),
//     employee: "employee e",
//     Location: "Location l",
//     Type: "Type t",
//     ExtraTime: 25);

class EmployeeAttendModel {
    DateTime date ;
    String employee ;
    String Location ;
    String type ;
    int ExtraTime ;

    EmployeeAttendModel({
      required this.date,
      required this.employee,
      required this.Location,
      required this.type,
      required this.ExtraTime,
    });
}