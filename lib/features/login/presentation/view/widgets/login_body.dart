import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/attendance/attendance_exports.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/login/presentation/view/manager/login_cubit.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/otp/otp_exports.dart';
import 'package:flutter/material.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/core/core_exports.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../otp/presentation/view_model/manger/otp_cubit/otp_cubit.dart';
class LoginBody extends StatefulWidget {
   LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

   bool visibilityHidden = true ;

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {

        if (state is LoginSuccessState) {
          print("success");
          Future.delayed(Duration(milliseconds: 500),(){
            CacheHelper.saveData(
                key: "token", value: state.loginData.user.apiToken);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context){
                  return AttendanceView();
                }), (route) => false);
          });
        }

        return null;
      },

      builder: (BuildContext context, LoginState state) {
        return Scaffold(
          backgroundColor: ColorHelper.whiteColor,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              "assets/images/body/Rectangle1.png",
                              color: ColorHelper.mainColor.shade100,
                              width: _widthScreen*0.484,
                              height: _heightScreen*0.167,//142

                            ),
                            Image.asset(
                              "assets/images/body/Rectangle1.png",
                              color: ColorHelper.mainColor,
                              height: _heightScreen*0.134, //114

                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Image.asset(
                                  "assets/images/body/Rectangle2.png",
                                  color: ColorHelper.mainColor.shade100,
                                  width: _widthScreen*0.339,
                                  height: _heightScreen*0.098,
                                ),
                                Image.asset(
                                  "assets/images/body/Rectangle2.png",
                                  color: ColorHelper.mainColor,
                                  height: _heightScreen* 0.065,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Text(
                                      //"Abraj Al Buhaira attendance",
                                      "ABRAJ  AL  BUHAIRA ",
                                      style:TextStyleHelper.textStyle11.copyWith(color: ColorHelper.borderColor),
                                    ),*/
                                Text(
                                  "Email: Arabj_Uae@hotmail.com ",
                                  style:TextStyleHelper.textStyle11.copyWith(fontSize:10,color: ColorHelper.borderColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Box: 72080-Sharjah UAE",
                                  style:TextStyleHelper.textStyle11.copyWith(fontSize:10,color: ColorHelper.borderColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Tel: 06-5637066",
                                      style:TextStyleHelper.textStyle11.copyWith(fontSize:10,color: ColorHelper.borderColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Fax: 06-5637067",
                                      style:TextStyleHelper.textStyle11.copyWith(fontSize:10,color: ColorHelper.borderColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // org.gradle.jvmargs=-Xmx1536M
                  Form(
                    key: _formKey,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: _heightScreen*0.235,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Welcome ",
                                        style:TextStyleHelper.textStyle28,
                                      ),
                                      Text(
                                        "Back !",
                                        style: TextStyleHelper.textStyle28.copyWith(color: ColorHelper.mainColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: _heightScreen * 0.011,),
                                  Text(
                                    "Login ",
                                    style:TextStyleHelper.textStyle20.copyWith(color: ColorHelper.text2Color),
                                  ),
                                  SizedBox(height: _heightScreen*0.059,),
                                  CustomTextFormField(
                                    controller:mobileController,
                                    hintText: "Mobile",
                                    heightFilled: _heightScreen*0.1,
                                    //heightFilled: _heightScreen*0.077,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validation: (String? value){
                                        if(value == '' || value==null){
                                          return "mobile required";
                                        }
                                        if(value.length != 11 &&value!="0123456789"){
                                          return "invalid mobile";
                                        }
                                        print(value.length);

                                    },
                                    hintStyle: TextStyleHelper.textStyle14.copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff737373) ),
                                    backgroundFilled: ColorHelper.textFieldBackground,
                                    borderColor: ColorHelper.borderColor,
                                    prefixIcon: Image.asset(ImageHelper.iconUser,color: ColorHelper.text2Color),

                                  ),
                                  SizedBox(height: _heightScreen*0.025,),
                                  CustomTextFormField(
                                    controller:passwordController,
                                    validation: (String? value){
                                      if(value == '' || value==null){
                                        return "password required";
                                      }

                                    },
                                    hintText: "Password",
                                    obscureText: (visibilityHidden)?true:false,
                                    suffixIcon: GestureDetector(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: (visibilityHidden)?Icon(Icons.visibility_outlined,):Icon(Icons.visibility_off_outlined,),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          visibilityHidden = !visibilityHidden;
                                        });
                                      },
                                    ),
                                      heightFilled: _heightScreen*0.1,
                                    hintStyle: TextStyleHelper.textStyle14.copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff737373) ),
                                    backgroundFilled: ColorHelper.textFieldBackground,
                                    borderColor: ColorHelper.borderColor,
                                    prefixIcon: Image.asset(ImageHelper.iconPassword,color: ColorHelper.text2Color),

                                  ),
                                  SizedBox(height: _heightScreen*0.02,),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: (){
                                       /* showProgressIndicator(context);
                                        _register(context);*/
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context){
                                            return TakePhone();
                                          }),
                                        );
                                      },
                                      child: Text(
                                        "Forget Password ? ",
                                        style:TextStyleHelper.textStyle13.copyWith(color: ColorHelper.mainColor),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              SizedBox(height: _heightScreen*0.7,),
                              CustomButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    context.read<LoginCubit>().signIn(mobileController.text, passwordController.text);
                                  }

                                },
                                text:"Login",
                                textStyle:  TextStyleHelper.textStyle16.copyWith(color: ColorHelper.whiteColor),
                              ),
                              SizedBox(height:_heightScreen*0.03,),
                              (state is LoginErrorState)?
                                     Container(
                                width: double.infinity,
                                height: _heightScreen*0.073,
                                padding: EdgeInsets.all(12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorHelper.redColor.shade50.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "${state.errorMessage}",
                                  style:TextStyleHelper.textStyle11.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: ColorHelper.redColor,
                                  ),

                                ),
                              ):
                                     (state is LoginSuccessState && (mobileController.text.isNotEmpty ||passwordController.text.isNotEmpty))?
                                     Container(
                                width: double.infinity,
                                height: _heightScreen*0.075,
                                padding: EdgeInsets.all(12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorHelper.greenColor.shade50.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "successful login ! ",
                                  style:TextStyleHelper.textStyle11.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: ColorHelper.greenColor,
                                  ),

                                ),
                              ):
                                     SizedBox(),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              (state is LoginLoadingState)?
                  CircularIndicatorScreenLoading():SizedBox(),
            ],
          ),
        ) ;
      },
    );
  }
}


