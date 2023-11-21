import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/data/models/get_location_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/core_exports.dart';

part 'get_locations_state.dart';

class GetLocationsCubit extends Cubit<GetLocationsState> {

  static GetLocationsCubit get(context) => BlocProvider.of(context);

  GetLocationsCubit() : super(GetLocationsInitial());

  Future<void> getAllLocations () async{

    emit(GetLocationsLoadingState());
    try{
      final GetLocationsModel data = await ApiClient().getLocations();
      emit(GetLocationsSuccessState(getLocationsData: data));

    }on DioException catch(e){
      String message = 'sorry ! there was an Error, try again !';
      bool _logout = false ;
      bool _tryAgain = false ;
      if(e.type == DioExceptionType.connectionError){
        message = 'there is no internet! make sure your connection and try again !';
        _tryAgain = true ;
      }
      if(e.type == DioExceptionType.badResponse){
        //don't change this text because this text used in condition in attendance_body file
        message = "can't get locations!";
        _tryAgain = true ;
      }

      if(e.type == DioExceptionType.cancel){
        message = 'your process cancelled!';
        _tryAgain = true ;
      }

      if(e.response?.statusCode == 404){
        message = 'Your request not found, try again later !';
      }

      if(e.response?.statusCode == 500){
        message = 'Internal Server error, try again later !';
      }
      if(e.response?.statusCode == 401){
        message = 'sorry unauthorized you ! , you must login again !';
        _logout = true;
        _tryAgain = false;

      }

      emit(GetLocationsErrorState(errorMessage: message,logout: _logout,tryAgain: _tryAgain));

    }


  }


}
