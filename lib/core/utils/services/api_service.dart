import 'dart:io';

import 'package:dio/dio.dart';
import '../../../features/features_exports.dart';

class ApiClient {
  final _dio = Dio(
    BaseOptions(baseUrl: "https://server.poultrystore.net/api"),
  );

  Future<LoginModel> loginPostData({
    required String mobile,
    required String password,
  }) async {
    Response response = await _dio.post(
      '/employee/login',
      data: {
        'mobile': mobile,
        'password': password,
      },
      options: Options(headers: {
        "apiSecret": "M1SzcokloEgA20Ivh",
        "lang": "ar",
      }),
    );
    final data = LoginModel.fromJson(response.data);

    /*print("----------------------------");
      print(data.msg);
      print(data.errNum);
      print({"name : ${data.user.name}"});
      print({"mobile : ${data.user.mobile}"});
      print({"id : ${data.user.id}"});
      print({"type : ${data.user.type}"});*/
    return data;
  }

  Future<AttendanceModel?> takeAttendance(
      {required String date,
      required int employeeId,
      required int locationId,
      required String type,
      required int overtime,
      }) async {

      final token = await CacheHelper.getData(key: "token");
      print(token);
      Response response = await _dio.post(
        '/employee/store_attendance',
        data: FormData.fromMap({
          'date': date,
          'employee_id': employeeId,
          'location_id': locationId,
          'type': type,
          'overtime': overtime,
        }),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "apiSecret": "M1SzcokloEgA20Ivh",
            "lang": "ar"
          },
        ),
      );

     // print("response =============> ${response}");

      final data = AttendanceModel.fromJson(response.data);

      /*print("data =============> $data");
      print("----------------------------");
      print({"user : ${data.user}"});
      print({"status : ${data.status}"});
      print({"errNm : ${data.errNum}"});
      print({"msg : ${data.msg}"});*/
      return data;

/*      print('GUBA :: error is ${e.response}');
      print('GUBA :: error is ${e.message}');
      print('GUBA :: error is ${e.requestOptions.data}');
      print('GUBA :: error is ${e.requestOptions.headers}');*/

  }

Future<GetEmployeesModel> getEmployees () async{

    final token = await CacheHelper.getData(key: "token");
   // print(token);
    Response  response = await _dio.post(
      '/employee/get_employees',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "apiSecret": "M1SzcokloEgA20Ivh",
          "lang": "ar"
        }
      ),
    );


    final data = GetEmployeesModel.fromJson(response.data);

    return data;

}

Future<GetLocationsModel> getLocations () async{

    final token = await CacheHelper.getData(key: "token");
    
    Response  response = await _dio.post(
      '/employee/get_locations',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "apiSecret": "M1SzcokloEgA20Ivh",
          "lang": "ar"
        }
      ),
    );


    final data = GetLocationsModel.fromJson(response.data);

    return data;

}

  Future<ShowLastAttendanceModel> showLastAttendance () async{

    final token = await CacheHelper.getData(key: "token");
    Response  response = await _dio.post(
      '/employee/get_attendances',
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "apiSecret": "M1SzcokloEgA20Ivh",
            "lang": "ar"
          }
      ),
    );


    final   data = ShowLastAttendanceModel.fromJson(response.data);
    print("=[Json]=========================> [ Ali ] <=====================\n");
    print(response.data["list"]["data"][0]["employee"]["name"]);
    print("=[modeling]=========================> [ Ali ] <=====================\n");
    print("${data.list.employeesData[0]}");
    print("============================================");
    return data;



  }

}
