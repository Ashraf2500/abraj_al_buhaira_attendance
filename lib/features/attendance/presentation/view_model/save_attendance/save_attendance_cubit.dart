import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/attendance_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/core_exports.dart';
import '../../../../features_exports.dart';

part 'save_attendance_state.dart';

class SaveAttendanceCubit extends Cubit<SaveAttendanceState> {

  static SaveAttendanceCubit get(context) => BlocProvider.of(context);

  SaveAttendanceCubit() : super(SaveAttendanceInitial());

  Future<void> saveAttend ({
        required String date,
        required int employeeId,
        required int locationId,
        required String type,
        required int overtime,

      }) async{

    emit(SaveAttendanceLoadingState());
    try{
      final data = await ApiClient().takeAttendance(date: date,employeeId:employeeId,locationId:locationId , type: type , overtime: overtime);
      emit(SaveAttendanceSuccessState(attendanceData: data));
    }on DioException catch(e){
      String message = ' sorry ! there was an Error, please try again !';
      bool _logout = false ;
      if(e.type == DioExceptionType.connectionError){
        message = ' there is no internet! make sure your connection, and try again !';
      }
      if(e.type == DioExceptionType.badResponse){
        message = ' your data not correct, try again !';
      }

      if(e.type == DioExceptionType.cancel){
        message = 'your process cancelled';
      }

      if(e.response?.statusCode == 404){
        message = 'Your request not found, Please try again later !';
      }

      if(e.response?.statusCode == 500){
        message = 'Internal Server error, Please try again later !';
      }
      if(e.response?.statusCode == 401){
        message = 'sorry unauthorized Error ! , please login again !';

      }

      emit(SaveAttendanceErrorState(errorMessage: message,logout:_logout ));

    }


  }


}
