import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/presentation/view_model/show_last_attendance_cubit/show_last_attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


class ShowAttendance extends StatelessWidget {
   ShowAttendance({
     Key? key,


   }) : super(key: key);

   List<EmployeeAttendModel> listOfEmployeeAttend= [EmployeeAttendModel(date: DateTime.now(), employee: "employee", Location: "Location", type: "type", ExtraTime: 5)];

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;

    return Container(
      height: _heightScreen,
      child: (listOfEmployeeAttend.isEmpty)?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: _widthScreen*0.6,
                  child: Lottie.asset('assets/svg/empty_animation.json'),
              ),
              SizedBox(
                height: _heightScreen*0.05,
              ),
              Text(
                  "No employee has attended the event yet",
                  style: TextStyleHelper.textStyle11.copyWith(color:Colors.grey.shade500),
              ),
            ],
          )
      :BlocBuilder<ShowLastAttendanceCubit,ShowLastAttendanceState>(
        builder: (context,state) {

          if(state is ShowLastAttendanceLoadingState ){
            print("loading");
            return Center(
              child: Container(
                  width: _widthScreen*0.7,
                  child: Lottie.asset(
                      "assets/svg/animation_loading_file_4.json")),
            );
          }
          if(state is ShowLastAttendanceSuccessState ){
            final List<EmployeesData> listOfEmployeesAttend  = state.ShowLastAttendanceData.list.employeesData;
            print("Success list");
            return ListView.builder(
              itemCount: listOfEmployeesAttend.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index){
                print(listOfEmployeesAttend[index].employeeInfo.mobile);
                return Column(
                  children: [
                    (index==0)?SizedBox(height: 20,):SizedBox(),
                    CustomOneAttendItem(employeesData: listOfEmployeesAttend[index],),
                  ],
                );
              },

            );
          }
          else if (state is ShowLastAttendanceErrorState){
            print("error");
            return Container(
              width: _widthScreen,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset(
                          "assets/svg/Animation_error_2.json")),
                  SizedBox(
                    height: _heightScreen * 0.03,
                  ),
                  Text(
                    "${state.errorMessage}",
                    style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                    textAlign: TextAlign.center,
                  ),
                  //-------------------------------------------------------------

                ],
              ),
            );
          }
          else {
            return Container(
              width: _widthScreen,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset(
                          "assets/svg/Animation_error_2.json")),
                  SizedBox(
                    height: _heightScreen * 0.03,
                  ),
                  Text(
                    "sorry ! there was an Error, try again",
                    style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                    textAlign: TextAlign.center,
                  ),
                  //-------------------------------------------------------------

                ],
              ),
            );
          }
        }
      ),
    );
  }
}


