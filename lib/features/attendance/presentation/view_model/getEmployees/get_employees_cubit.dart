import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/attendance_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/core_exports.dart';

part 'get_employees_state.dart';

class GetEmployeesCubit extends Cubit<GetEmployeesState> {

  static GetEmployeesCubit get(context) => BlocProvider.of(context);
  GetEmployeesCubit() : super(GetEmployeesInitial());


  Future<void> getAllEmployee () async{

    emit( GetEmployeesLoadingState());
    try{

      final GetEmployeesModel data = await ApiClient().getEmployees();
      emit(GetEmployeesSuccessState(getEmployeesData: data));

    }on DioException catch(e){
      String message = 'sorry ! there was an Error, try again !';
      bool _logout = false ;
      bool _tryAgain = false ;

      if(e.type == DioExceptionType.connectionError){
        message = 'there is no internet! make sure your connection and try again !';
        _tryAgain = true;
      }
      if(e.type == DioExceptionType.badResponse){
        //don't change this text because this text used in condition in attendance_body file
        message = "can't get employees!";
        _tryAgain = true;
      }

      if(e.type == DioExceptionType.cancel){
        message = 'your process cancelled!';
        _tryAgain = true;
      }

      if(e.response?.statusCode == 404){
        message = 'Your request not found, try again later !';
      }

      if(e.response?.statusCode == 500){
        message = 'Internal Server error, try again later !';

      }
      if(e.response?.statusCode == 401){
        message = 'sorry unauthorized Error ! , you must login again !';
        _logout = true;
        _tryAgain = false;

      }

      emit(GetEmployeesErrorState(errorMessage: message, logout:_logout,tryAgain: _tryAgain));

    }


  }
}


