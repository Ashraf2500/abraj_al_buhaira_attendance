import 'package:flutter/material.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';

class CustomOneAttendItem extends StatelessWidget {
   CustomOneAttendItem({
    super.key,
      required this.employeesData,
  });

   final EmployeesData employeesData ;

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;

    return Container(
      width: _widthScreen,
      height: _heightScreen*0.132,
      margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
      padding: const EdgeInsets.only(left: 2.0,right: 12.0,bottom: 12.0,top: 8),
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(2, 2),
            )
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/body/persons/person_1.png",
            height: 60,
            color: (int.parse(employeesData.status)==-1)? ColorHelper.redColor.shade400:
            (int.parse(employeesData.status)==1&&int.parse(employeesData.overtime)>0)? ColorHelper.greenColor.shade400:
            ColorHelper.mainColor,

          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _widthScreen*0.40,
                  child: Text(
                      "${employeesData.employeeInfo.name}",
                      style: TextStyleHelper.textStyle14,
                      overflow:TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${employeesData.locationInfo.name}",
                  style: TextStyleHelper.textStyle13,
                ),
                Spacer(),
                Text(
                    "${employeesData.date.day}-${employeesData.date.month}-${employeesData.date.year}",
                    style: TextStyleHelper.textStyle11,
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: _widthScreen*0.21,
                height: 40,
                margin: EdgeInsets.only(top: 0,),
                alignment: Alignment.center,
                decoration: BoxDecoration(

                    color: (int.parse(employeesData.status)==-1)? ColorHelper.redColor.shade400:
                           (int.parse(employeesData.status)==1&&int.parse(employeesData.overtime)>0)? ColorHelper.greenColor.shade400:
                           ColorHelper.mainColor,
                    //border: Border.all(),
                    borderRadius: BorderRadius.circular(4.0)

                ),
                child: Text(
                  (int.parse(employeesData.status)==-1)? 'Absent':
                  (int.parse(employeesData.status)==1&&int.parse(employeesData.overtime)>0)? 'OverTime':"Attend",
                  style: TextStyleHelper.textStyle13.copyWith(fontWeight: FontWeight.w600,color: ColorHelper.whiteColor),
                ),

              ),
              Spacer(),
              (int.parse(employeesData.status)==-1)?Text(
                "No overtime",
                style: TextStyleHelper.textStyle11.copyWith(color: ColorHelper.blackColor),
              ):
              (int.parse(employeesData.status)==1&&int.parse(employeesData.overtime)>0)?
                 Text(
                "${employeesData.overtime} Hours overtime",
                style: TextStyleHelper.textStyle11.copyWith(color: ColorHelper.greenColor),
              ):
                 Text(
                "No overtime",
                style: TextStyleHelper.textStyle11.copyWith(color: ColorHelper.blackColor,),
              ),

            ],
          ),
        ],
      ),
    );

    // return Container(
    //   padding: EdgeInsets.all( 16.0),
    //   margin: EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text("Ashraf Hatem"),
    //       Text("Location a"),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Row(
    //             children: [
    //               Text("Attend"),
    //               SizedBox(width: 20,),
    //               Text("3"),
    //             ],
    //           ),
    //           Text("2-11-2023"),
    //         ],
    //       ),
    //     ],
    //   ),
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       color: ColorHelper.borderColor,
    //     ),
    //     borderRadius: BorderRadius.circular(8.0),
    //   ),
    // );
  }
}
