import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/presentation/view_model/getEmployees/get_employees_cubit.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/presentation/view_model/get_locations/get_locations_cubit.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/presentation/view_model/save_attendance/save_attendance_cubit.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';
import 'package:awesome_number_picker/awesome_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:search_choices/search_choices.dart';

import '../../view_model/show_last_attendance_cubit/show_last_attendance_cubit.dart';

class AttendanceBody extends StatefulWidget {
  const AttendanceBody({Key? key}) : super(key: key);

  @override
  State<AttendanceBody> createState() => _AttendanceBodyState();
}

class _AttendanceBodyState extends State<AttendanceBody>
    with SingleTickerProviderStateMixin {

  bool fingerSwitchWork =false;
  void getFingerShared()async{

    final finger = await CacheHelper.getData(key: "finger");
    if(finger=="true"){
      setState(() {
        fingerSwitchWork = true;
      });
    }
    else if(finger=="false"){
      setState(() {
        fingerSwitchWork = false;
      });
    }
    else{
      setState(() {
        fingerSwitchWork = false ;
      });
    }
  }


  DateTime _selectedDateTimeValue = DateTime.now();

  List<String> listOfTypes = [
    'Attend',
    'Extra time',
  ];

  TextEditingController textEditingControllerMenu1 = TextEditingController();
  TextEditingController textEditingControllerMenu2 = TextEditingController();
  String selectedLocation = 'select';

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),


    ).then((value) {
      setState(() {
        print("=========================> ${value!.isBefore(DateTime.now())}");
        if(value!.isBefore(DateTime.now())){
          _selectedDateTimeValue = value!;
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ColorHelper.redColor,
            elevation: 30,
            duration: Duration(milliseconds: 2000),
            content: Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              alignment: Alignment.bottomCenter,
              child: Text(
                // "Successfully save",
                "Sorry , can't choose date in future",
                style: TextStyleHelper.textStyle14.copyWith(fontSize: 15),
              ),
            ),
          ));
        }
        // employee.Date=value;
      });
    });
  }

  int integerValue = 0;

  var selectedEmployee;

  int _currentValue = 3;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<GetEmployeesCubit>().getAllEmployee();
    context.read<GetLocationsCubit>().getAllLocations();
    context.read<ShowLastAttendanceCubit>().showLastAttend();
    getFingerShared();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  OneLocation? location;
//  OneEmployee? employeeChoice;
  String? employeeChoiceName;
  int? markEmployeeId;
  int? employeeIdInt ;


  var types = <String>[
    'Attend',
    'Overtime',
    'Cancel',
  ];
  String? _selectType = "Attend";

  bool _isLoading = false;
  bool _isValidate = false;
  bool _canOvertime = false;
  bool _tryAgain = false;

  List<EmployeeAttendModel> listOfEmployeeAttend = [];
  EmployeeAttendModel employee = EmployeeAttendModel(
      date: DateTime.now(),
      employee: "employee e",
      Location: "Location l",
      type: "Type t",
      ExtraTime: 25);

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;

    double _widthItemsSelection = MediaQuery.of(context).size.width * 0.57;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorHelper.whiteColor,
      drawer: DrawerBody(fingerSwitchIsWork:fingerSwitchWork),
      appBar: AppBar(
        toolbarHeight: 45,
        actions: [
          GestureDetector(
            onTap: () async {
              context.read<GetEmployeesCubit>().getAllEmployee();
              //context.read<GetLocationsCubit>().getAllLocations();
              context.read<ShowLastAttendanceCubit>().showLastAttend();
            },
            child: Container(
              width: 25,
              margin: EdgeInsets.only(right: 16.0, top: 10),
              child: Icon(Icons.refresh,color: Colors.white,),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Take attend",
            ),
            Tab(
              text: "attendance",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                BlocBuilder<GetEmployeesCubit, GetEmployeesState>(
                  builder: (contextEmployees, stateEmployees) {
                    return BlocBuilder<GetLocationsCubit, GetLocationsState>(
                        builder: (contextLocations, stateLocations) {
                      if (stateEmployees is GetEmployeesLoadingState ||
                          stateLocations is GetLocationsLoadingState) {
                        print("Loading");
                        return Container(
                          height: _heightScreen - (_heightScreen*0.1),
                          child: Center(
                            child: SizedBox(
                                //height: h,
                                width: _widthScreen*0.7,
                                child: Lottie.asset(
                                    "assets/svg/animation_loading_file_4.json")),
                          ),
                        );
                        /*return Container(
                          child: CircularIndicatorScreenLoading(),
                        );*/
                        //return CircularIndicatorScreenLoading();
                      }
                      if ((stateEmployees is GetEmployeesSuccessState &&
                          stateLocations is GetLocationsSuccessState)) {
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: _heightScreen * 0.03,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Take ",
                                    style: TextStyleHelper.textStyle28,
                                  ),
                                  Text(
                                    "Attend !",
                                    style: TextStyleHelper.textStyle28
                                        .copyWith(color: ColorHelper.mainColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _heightScreen * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyleHelper.textStyle16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showDatePicker();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 58,
                                          width: _widthItemsSelection -
                                              (_widthItemsSelection * 0.21),
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            "${_selectedDateTimeValue.day}-${_selectedDateTimeValue.month}-${_selectedDateTimeValue.year}",
                                            style: TextStyleHelper.textStyle13,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorHelper.borderColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0).copyWith(
                                              topRight: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 58,
                                          width: _widthScreen * 0.12,
                                          child: Center(
                                            child: Icon(
                                              Icons.calendar_month,
                                              color: ColorHelper.whiteColor,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorHelper.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0)
                                                    .copyWith(
                                              topLeft: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _heightScreen * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Employee ",
                                    style: TextStyleHelper.textStyle14,
                                  ),
                                  (employeeChoiceName==null && _isValidate)?Text(
                                    "*",
                                    style: TextStyleHelper.textStyle16.copyWith(color: ColorHelper.redColor),
                                  ):SizedBox(),
                                  Container(
                                    height: 58,
                                    width: _widthItemsSelection,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorHelper.borderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SearchChoices.single(
                                      onClear: (){
                                        employeeChoiceName = null;
                                      },
                                      underline: Container(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      items: stateEmployees.getEmployeesData.employees.data.map((OneEmployee employeeChoices) {
                                       // print("getEmployeesData.employees.data ===> ${employeeChoices.name}");
                                        return DropdownMenuItem<String>(
                                          value: employeeChoices.name+"+@#+"+employeeChoices.id.toString(),
                                          child: Text(
                                            employeeChoices.name,
                                            style: TextStyleHelper.textStyle13
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        ColorHelper.blackColor),
                                          ),
                                        );
                                      }).toList(),
                                      value: employeeChoiceName,
                                      hint: "select employee",
                                      searchHint: "select employee",
                                      onChanged: (String value) {
                                        setState(() {
                                          //print("$employeeChoice");
                                          //employeeChoice = value;
                                          employeeChoiceName = value+"";
                                          print("Employee ===> $employeeChoiceName");
                                        });
                                      },
                                      dialogBox: true,
                                      isExpanded: true,
                                      style: (selectedEmployee == null)
                                          ? TextStyleHelper.textStyle13.copyWith(
                                              color: ColorHelper.text3Color,
                                            )
                                          : TextStyleHelper.textStyle13.copyWith(
                                              color: ColorHelper.blackColor,
                                            ),
                                      dropDownDialogPadding: EdgeInsets.only(
                                        top: _heightScreen * 0.01,
                                        bottom: _heightScreen * 0.37,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _heightScreen * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Location ",
                                    style: TextStyleHelper.textStyle13,
                                  ),
                                  (location==null && _isValidate)?Text(
                                    "*",
                                    style: TextStyleHelper.textStyle16.copyWith(color: ColorHelper.redColor),
                                  ):SizedBox(),
                                  // Container(
                                  //   width: _widthItemsSelection,
                                  //   child: Container(
                                  //     child: CustomDropDownMenu(
                                  //       label: "Location",
                                  //       listChoices: listOfLocation,
                                  //     ), //todo
                                  //   ),
                                  // ),

                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.57,
                                    height: 58,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorHelper.borderColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8.0)),
                                    ),
                                    child: DropdownButton<OneLocation>(
                                      hint: Text("Select a location"),
                                      style: TextStyleHelper.textStyle13,
                                      borderRadius: BorderRadius.circular(8.0),
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      value: location,
                                      onChanged: (OneLocation? newValue) {
                                        setState(() {
                                          location = newValue;
                                        });
                                      },
                                      items: stateLocations
                                          .getLocationsData.locations.data
                                          .map((OneLocation oneLocation) {
                                        return DropdownMenuItem<OneLocation>(
                                          value: oneLocation,
                                          child: Text(
                                            oneLocation.name,
                                            style: TextStyleHelper.textStyle13
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        ColorHelper.blackColor),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _heightScreen * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Type ",
                                    style: TextStyleHelper.textStyle13,
                                  ),
                                  Container(
                                    width: _widthItemsSelection,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.57,
                                      height: 58,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorHelper.borderColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: DropdownButton<String>(
                                        hint: Text('Select type'),
                                        style: TextStyleHelper.textStyle13,
                                        borderRadius: BorderRadius.circular(8.0),
                                        underline: SizedBox(),
                                        isExpanded: true,
                                        value: _selectType == null
                                            ? null
                                            : _selectType,
                                        items: types.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyleHelper.textStyle13
                                                  .copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color:
                                                          ColorHelper.blackColor),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                            if(value !="Overtime"){
                                               setState(() {
                                                 _selectType = value;
                                                 integerValue = 0;
                                                 _canOvertime=false;

                                               });
                                            }else{
                                              setState(() {
                                                _selectType = value;
                                                _canOvertime=true;
                                              });
                                            }

                                        },
                                      ),
                                    ),
                                    /* child: Container(
                                           child: CustomDropDownMenu(
                                             label: 'Type',
                                             listChoices: listOfTypes,
                                           ),
                                         ),*/
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(left: (_canOvertime)? 0: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Overtime ",
                                          style: TextStyleHelper.textStyle13,
                                        ),
                                        Container(
                                          width: _widthItemsSelection + 10,
                                          height: _heightScreen * 0.15,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: _widthItemsSelection * 0.5,
                                                color: Colors.grey.shade100,
                                              ),
                                              IntegerNumberPicker(
                                                size: 35,
                                                initialValue: 1,
                                                minValue: 1,
                                                maxValue: 25,
                                                otherItemsDecoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.shade200.withOpacity(0.8),
                                                        blurRadius: 2,
                                                        spreadRadius: 1),
                                                  ],
                                                ),
                                                pickedItemDecoration: BoxDecoration(
                                                  //color: Colors.white.withOpacity(0.7),
                                                  color: Colors.grey.shade200.withOpacity(0.6),
                                                  border: Border.all(
                                                    color: ColorHelper.mainColor,
                                                    width: 1.8,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                                pickedItemTextStyle: TextStyleHelper
                                                    .textStyle16
                                                    .copyWith(
                                                  color: ColorHelper.mainColor,
                                                ),
                                                otherItemsTextStyle: TextStyleHelper
                                                    .textStyle13
                                                    .copyWith(
                                                  color: Colors.black54,
                                                ),
                                                axis: Axis.horizontal,
                                                onChanged: (i) => setState(() {
                                                  integerValue = i;
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (_canOvertime==false)?
                                      Container(
                                        height: 58,
                                        width: _widthScreen,
                                     //  padding: EdgeInsets.only(left: ),
                                       decoration: BoxDecoration(
                                         color: Colors.grey.shade200.withOpacity(0.5),
                                         borderRadius: BorderRadius.circular(8.0),
                                       ),
                                      ):
                                      SizedBox(),
                                ],
                              ),
                              SizedBox(height: _heightScreen * 0.01),
                              BlocConsumer<SaveAttendanceCubit, SaveAttendanceState>(
                                  listener: (context, state) {
                                if (state is SaveAttendanceLoadingState) {
                                  print(" loading Save");
                                  setState(() {
                                    _isLoading = true;
                                    _isValidate= false;
                                  });

                                }
                                if (state is SaveAttendanceSuccessState) {
                                  print("employeeChoice!.id ===>${state.attendanceData.user}");
                                  print(" success Save");
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: ColorHelper.greenColor,
                                    elevation: 30,
                                    duration: Duration(milliseconds: 2000),
                                    content: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                       // "Successfully save",
                                        "${state.attendanceData.user}",
                                        style: TextStyleHelper.textStyle14.copyWith(fontSize: 15),
                                      ),
                                    ),
                                  ));

                                }
                                if (state is SaveAttendanceErrorState) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: ColorHelper.redColor,
                                    padding: EdgeInsets.all(12),
                                    elevation: 30,
                                    duration: Duration(milliseconds: 2000),
                                    content: Padding(
                                      padding: const EdgeInsets.only(left: 16.0,bottom: 4),
                                      child: Text(
                                        "${state.errorMessage}",
                                        style: TextStyleHelper.textStyle13,
                                      ),
                                    ),
                                  ));
                                  print(state.errorMessage);
                                }
                              },
                                  builder: (context, state) {
                                return CustomButton(
                                  onPressed: () {
                                    print ("employeeChoiceName before deleting ===>${employeeChoiceName}");
                                    print ("employeeChoiceName index===>${employeeChoiceName?.indexOf("+@#+")}");
                                    markEmployeeId = employeeChoiceName?.indexOf("+@#+");
                                    markEmployeeId= (markEmployeeId==null)?-404:markEmployeeId!+4;
                                    String employeeIdString=(employeeChoiceName==null)?"":employeeChoiceName!.replaceRange(0, markEmployeeId, "");
                                    try{
                                       employeeIdInt= int.parse(employeeIdString);
                                    }catch (e){
                                      employeeIdInt = -222444666;
                                    }
                                  //  print(employeeChoiceName);
                                    print ("employeeChoiceName after deleting ===>${employeeIdInt!}");

                                    if (employeeChoiceName != null &&
                                        location != null &&
                                        _selectType != null) {



                                      context.read<SaveAttendanceCubit>().saveAttend(
                                            date: "${"${_selectedDateTimeValue.year}-${_selectedDateTimeValue.month}-${_selectedDateTimeValue.day}"}",
                                            employeeId: employeeIdInt!,
                                            locationId: location!.id,
                                            type:(_selectType! == "Absence"||_selectType! == "absence")? "cancel":_selectType!.toLowerCase(),
                                            overtime: integerValue,
                                          );
                                      print("employeeChoice!.id ===>${employeeIdInt}");
                                      print("_selectType!.toLowerCase() ===>${_selectType!.toLowerCase()}");

                                    }
                                    else{
                                      setState(() {
                                        _isValidate = true ;
                                      });
                                    }
                                  },
                                  text: "Save",
                                );
                              }),
                              SizedBox(height: _heightScreen * 0.04),
                              (employeeChoiceName==null && location==null && _isValidate)?
                              Text(
                                "Employee and Location are required",
                                style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.redColor),
                              ):
                              (employeeChoiceName==null && _isValidate)?
                              Text(
                                  "Employee required",
                                style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.redColor),
                              ):
                              (location==null && _isValidate)?
                              Text(
                                "Location required",
                                style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.redColor),
                              ):
                              SizedBox(),
                              //SizedBox(height: _heightScreen * 0.07),
                            ],
                          ),
                        );
                      }
                      if ((stateEmployees is GetEmployeesErrorState ||
                          stateLocations is GetLocationsErrorState)) {
                               if(stateEmployees is GetEmployeesErrorState ){
                                    if(stateEmployees.logout){
                                         final token =  CacheHelper.removeData(key: "token").then((value) =>
                                Future.delayed(Duration(seconds: 4),(){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginView()), (route) => false);
                                })
                                        );
                                  }
                               }
                               if(stateLocations is GetLocationsErrorState ){
                                    if(stateLocations.logout){
                                      final token =  CacheHelper.removeData(key: "token").then((value) =>
                                Future.delayed(Duration(seconds: 4),(){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginView()), (route) => false);
                                })
                                     );
                                    }
                                }
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
                              (stateLocations is GetLocationsErrorState && stateEmployees is GetEmployeesSuccessState)
                                  ? Text(
                                      "${stateLocations.errorMessage}",
                                       style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                                      textAlign: TextAlign.center,
                                    ):
                              (stateLocations is GetLocationsSuccessState && stateEmployees is GetEmployeesErrorState)
                                  ? Text(
                                "${stateEmployees.errorMessage}",
                                style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                                textAlign: TextAlign.center,
                              ):
                              (stateLocations is GetLocationsErrorState && stateEmployees is GetEmployeesErrorState)
                                  ? (stateEmployees.errorMessage=="can't get employees!")?
                                    Text(
                                "can't get employees and locations!",
                                style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                                textAlign: TextAlign.center,
                              ) :
                                     (stateLocations.errorMessage=="can't get location!")?
                                     Text(
                                       "can't get employees and locations!",
                                       style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                                       textAlign: TextAlign.center,
                                     ) :
                                    Text(
                                "${stateEmployees.errorMessage}",
                                style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.blackColor.withOpacity(0.5)),
                                textAlign: TextAlign.center,
                              ) :
                                    SizedBox(),
                              //-------------------------------------------------------------

                              SizedBox(height: _heightScreen*0.03,),

                              (stateLocations is GetLocationsErrorState && stateEmployees is GetEmployeesSuccessState)?
                                        (stateLocations.tryAgain)?TryAgainTextError():SizedBox()
                              :(stateLocations is GetLocationsSuccessState && stateEmployees is GetEmployeesErrorState)?
                                      (stateEmployees.tryAgain)?TryAgainTextError():SizedBox()
                              :(stateLocations is GetLocationsErrorState && stateEmployees is GetEmployeesErrorState)?
                                      (stateEmployees.tryAgain)?TryAgainTextError():SizedBox()
                               :SizedBox(),

                            ],
                          ),
                        );
                      }
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
                    });
                  },
                ),
                (_isLoading)?CircularIndicatorScreenLoading():SizedBox(),
              ],
            ),
          ),
          RefreshIndicator(
            onRefresh: ()async{
              context.read<ShowLastAttendanceCubit>().showLastAttend();
            },
            color: ColorHelper.mainColor,
              child: ShowAttendance(),
          ),
        ],
      ),
    );
  }
}

class DrawerBody extends StatefulWidget {
   DrawerBody({
    super.key,
    required this.fingerSwitchIsWork,

  }) ;

   bool fingerSwitchIsWork ;

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {



  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Colors.grey.shade50,
      width: _widthScreen*0.7,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              thickness: 1,
              color: ColorHelper.whiteColor,
              height: 2,

            ),
            GestureDetector(
              child: Container(
                height: 75,
                color: Colors.grey.shade200.withOpacity(0.6),
                child: Center(
                  child: ListTile(
                    title: Text(
                      "FingerPrint",
                      style: TextStyleHelper.textStyle14.copyWith(color: ColorHelper.blackColor),
                    ),
                    leading: Container(
                      width:30 ,
                      child: Image.asset(
                        ImageHelper.iconUser,
                        color: ColorHelper.mainColor,
                      ),
                    ),
                    trailing: Switch(
                      // thumb color (round icon)
                      activeColor: ColorHelper.mainColor,
                      activeTrackColor: ColorHelper.mainColor.shade200,
                      inactiveThumbColor: Colors.blueGrey.shade600,
                      inactiveTrackColor: Colors.grey.shade400,
                      splashRadius: 50.0,
                      value: widget.fingerSwitchIsWork,
                      // changes the state of the switch
                      onChanged: (value){
                        setState(() {
                          widget.fingerSwitchIsWork = value ;

                          if(value){
                             CacheHelper.saveData(key: "finger", value: "true");
                          }else{
                            CacheHelper.saveData(key: "finger", value: "false");
                          }
                        });
                      },
                    ),
                    horizontalTitleGap: 4,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: ColorHelper.whiteColor,
              height: 2,

            ),
            /*GestureDetector(
              child: Container(
                height: 75,
                color: Colors.grey.shade200.withOpacity(0.6),
                child: Center(
                  child: ListTile(
                    title: Text(
                      "Language",
                      style: TextStyleHelper.textStyle14.copyWith(color: ColorHelper.blackColor),
                    ),
                    leading: Container(
                      width:30 ,
                      child: Image.asset(
                        ImageHelper.iconPassword,
                        color: ColorHelper.mainColor,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                    horizontalTitleGap: 4,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: ColorHelper.whiteColor,
              height: 2,

            ),*/
            GestureDetector(
              onTap: () async {
                final token = await CacheHelper.removeData(key: "token");
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                      return LoginView();
                    }), (route) => false);
              },
              child: Container(
                height: 75,
                color: Colors.grey.shade200.withOpacity(0.6),
                child: Center(
                  child: ListTile(
                    title: Text(
                      "Logout",
                      style: TextStyleHelper.textStyle14.copyWith(color: ColorHelper.blackColor),
                    ),
                    leading: Container(
                      width:30 ,
                      child: Image.asset(
                        ImageHelper.logout_4,
                        color: ColorHelper.redColor,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                    horizontalTitleGap: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TryAgainTextError extends StatelessWidget {
  const TryAgainTextError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){
            context.read<GetEmployeesCubit>().getAllEmployee();
            context.read<GetLocationsCubit>().getAllLocations();
            //context.read<ShowLastAttendanceCubit>().showLastAttend();
          },
          child: Text(
              "try again ",
            style: TextStyleHelper.textStyle13.copyWith(color: ColorHelper.mainColor),
            textAlign: TextAlign.start,
          ),
        );
  }
}

/*

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    super.key,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}
class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  TextEditingController textEditingControllerMenu = TextEditingController();

  String selectedLocation = listOfLocation.first;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: listOfLocation.first,
      width:  MediaQuery.of(context).size.width*0.57,
      hintText: "Type",
      controller: textEditingControllerMenu,

      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          selectedLocation = value!;
        });
      },
      dropdownMenuEntries: listOfLocation.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

*/

/*
class ContainerCustomClipper extends CustomClipper<Path> {
  var path = Path();

  @override
  */
/*Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    var firstControlPoint =
        new Offset(size.width - (size.width / 7), size.height - 30);
    var firstEndPoint =
        new Offset(size.width - (size.width / 6), (size.height / 1.5));

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 5), size.height / 4);
    var secondEndPoint =
        Offset(size.width - (size.width / 2.5), size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset((size.width * 0.42), size.height / 6.5);
    var thirdEndPoint = Offset(size.width * 0.38, size.height * 0.00);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move from bottom right to top

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }*/ /*


  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(size.width,0);
    path.lineTo(size.width,size.height);

    var firstControlPoint = new Offset(size.width-(size.width / 7), size.height - 30);
    var firstEndPoint = new Offset(size.width-(size.width / 6),(size.height / 1.5));

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width-(size.width / 5), size.height / 4);
    var secondEndPoint = Offset(size.width-(size.width /2.1),size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
    Offset((size.width *0.4),size.height / 6);
    var thirdEndPoint = Offset(size.width*0.38, size.height*0.00);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move from bottom right to top


    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ContainerCustomClipper2 extends CustomClipper<Path> {
  var path = Path();

  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    var firstControlPoint =
        new Offset(size.width - (size.width / 7), size.height - 30);
    var firstEndPoint =
        new Offset(size.width - (size.width / 6), (size.height / 1.5));

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 5), size.height / 4);
    var secondEndPoint =
        Offset(size.width - (size.width / 2.5), size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset((size.width * 0.42), size.height / 6.5);
    var thirdEndPoint = Offset(size.width * 0.38, size.height * 0.00);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move from bottom right to top

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
*/

/*    ClipPath(
                      clipper: ContainerCustomClipper(),
                      child: Container(
                        width: _widthScreen,
                        height: _heightScreen*0.22,
                        color: ColorHelper.mainColor.shade100,
                      ),
                    ),
                    ClipPath(
                      clipper: ContainerCustomClipper2(),
                      child: Container(
                        width: _widthScreen,
                        height: _heightScreen*0.2,
                        color: ColorHelper.mainColor,
                      ),
                    ),*/
