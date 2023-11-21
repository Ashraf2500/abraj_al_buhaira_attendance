import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/presentation/view_model/show_last_attendance_cubit/show_last_attendance_cubit.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/login/presentation/view/manager/login_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/otp/presentation/view_model/manger/otp_cubit/otp_cubit.dart';
import 'firebase_options.dart';

import 'features/attendance/presentation/view_model/getEmployees/get_employees_cubit.dart';
import 'features/attendance/presentation/view_model/get_locations/get_locations_cubit.dart';
import 'features/attendance/presentation/view_model/save_attendance/save_attendance_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    //   DevicePreview(
    //     enabled: true,
    //     builder: (context) => const MyApp(),
    // )
      const MyApp()

  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SaveAttendanceCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => GetEmployeesCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => GetLocationsCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => TakeAttendCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShowLastAttendanceCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => OtpCubit(),
        ),
      ],
      child :  MaterialApp(
        /*locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,*/
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    ),

    );
  }
}




/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

*/
