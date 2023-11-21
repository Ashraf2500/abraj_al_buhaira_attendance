import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());


  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> signIn (String mobile , String password) async {
     emit(LoginLoadingState());
     try{
       final data = await ApiClient().loginPostData(mobile:mobile, password:password);
       emit(LoginSuccessState(loginData: data));
     } on DioException catch(e) {
       String message = ' sorry ! there was an Error, please try again !';
       if(e.type == DioExceptionType.connectionError){
          message = ' there is no internet! make sure your connection, and try again !';
       }
       if(e.type == DioExceptionType.badResponse){
         message = ' mobile or password not correct, try again !';
       }

       if(e.type == DioExceptionType.cancel){
         message = 'Login cancelled';
       }

       if(e.response?.statusCode == 404){
         message = 'Your request not found, Please try again later !';
       }

       if(e.response?.statusCode == 500){
         message = 'Internal Server error, Please try again later !';
       }


       /* print(e);
        print(e.runtimeType);
        print('error          : ${e.error}');
        print('type           : ${e.type}');
        print('message        : ${e.message}');
        print('response       : ${e.response}');

        print('response.headers        : ${e.response?.headers}');
        print('response.data           : ${e.response?.data}');
        print('response.realUri        : ${e.response?.realUri}');
        print('response.statusCode     : ${e.response?.statusCode}');
        print('response.statusMessage  : ${e.response?.statusMessage}');

        print('requestOptions.data                       : ${e.requestOptions.data}');
        print('requestOptions.path                       : ${e.requestOptions.path}');
        print('requestOptions.uri                        : ${e.requestOptions.uri}');
        print('requestOptions.baseUrl                    : ${e.requestOptions.baseUrl}');
        print('requestOptions.headers                    : ${e.requestOptions.headers}');*/



       emit(LoginErrorState(errorMessage: message));
     }
  }
}
