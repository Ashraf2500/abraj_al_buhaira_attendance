import 'dart:io';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/core/core_exports.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:page_transition/page_transition.dart';

class FingerPrint {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> authAuth(BuildContext context) async {
    try {
      bool authenticate = await _localAuthentication.authenticate(
        localizedReason: "Please authenticate to continue",
        authMessages: [
          AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
            cancelButton: 'No thanks',
            
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ]);
        AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
          
        );

      final token = await CacheHelper.getData(key: "token");
      /*if (token != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SplashView()));
      }
      else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SplashView()));
      }*/
      if (token != null && authenticate) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: AttendanceView(),
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: Duration(milliseconds: 1500 ),
          ),
        );
      }
      else if(token == null && authenticate){
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: LoginView(),
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: Duration(milliseconds: 1500 ),
          ),
        );
      }
      else{
        FingerPrint().authAuth(context);
      }
    } on PlatformException catch (e) {
      cancelApp();
      if (e.code == auth_error.notEnrolled) {
        print("should cancel 1");
        cancelApp();
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        print("should cancel 2");
        cancelApp();
      } else {
        print("should cancel 3");
       cancelApp();
      }
    }
  }

  void cancelApp() {
    exit(0);
  }
}
