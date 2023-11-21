import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/attendance_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../core/core_exports.dart';

part 'show_last_attendance_state.dart';

class ShowLastAttendanceCubit extends Cubit<ShowLastAttendanceState> {
  ShowLastAttendanceCubit() : super(ShowLastAttendanceInitial());



  Future<void> showLastAttend () async{

    emit( ShowLastAttendanceLoadingState());
    try{

      final ShowLastAttendanceModel data = await ApiClient().showLastAttendance();
      emit(ShowLastAttendanceSuccessState(ShowLastAttendanceData: data));

    }on DioException catch(e){
      String message = 'sorry ! there was an Error';
      if(e.type == DioExceptionType.connectionError){
        message = 'there is no internet! make sure your connection, and try again !';

      }
      if(e.type == DioExceptionType.badResponse){
        message = "can't get employees, try again !";
      }

      if(e.type == DioExceptionType.cancel){
        message = 'your process cancelled!';
      }

      if(e.response?.statusCode == 404){
        message = 'Your request not found, try again later !';
      }

      if(e.response?.statusCode == 500){
        message = 'Internal Server error, try again later !';
      }

      emit(ShowLastAttendanceErrorState(errorMessage: message));

    }


  }

}

