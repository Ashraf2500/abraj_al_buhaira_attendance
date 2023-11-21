import 'package:abraj_al_buhaira_attendance_eng_ashraf/core/core_exports.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/login/presentation/view/login_view_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../view_model/manger/otp_cubit/otp_cubit.dart';

class OtpBody extends StatefulWidget {
  OtpBody({Key? key, required this.phoneNumber}) : super(key: key);
  final phoneNumber;

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  late String otpCode;

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ), // CircularProgressIndicator
      ), // Center
    ); // AlertDialog
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<OtpCubit, OtpState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          return showProgressIndicator(context);
        }
        if (state is PhoneOtpVerified) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                print("Success_khema");
                return LoginView();
              },
            ),
          );
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMessage = (state).errorMessage;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        } // SnackBar
      },
      child: Container(),
    );
  }
  void _login(BuildContext context){
    BlocProvider.of<OtpCubit>(context).submitOtp(otpCode);
  }

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
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
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Stack(
                  //     alignment: Alignment.bottomLeft,
                  //     children: [
                  //       Image.asset(
                  //         "assets/images/body/Rectangle2.png",
                  //         color: ColorHelper.mainColor.shade100,
                  //         width: _widthScreen*0.339,
                  //         height: _heightScreen*0.098,
                  //       ),
                  //       Image.asset(
                  //         "assets/images/body/Rectangle2.png",
                  //         color: ColorHelper.mainColor,
                  //         height: _heightScreen* 0.065,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                    child: Align(
                      alignment: Alignment.bottomLeft,
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
                          Text(
                            "Tel: 06-5637066",
                            style:TextStyleHelper.textStyle11.copyWith(fontSize:10,color: ColorHelper.borderColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Fax: 06-5637067",
                            style:TextStyleHelper.textStyle11.copyWith(fontSize:10,color: ColorHelper.borderColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30,vertical: _heightScreen*0.13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text(
                    'verify your phone Number',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter your 6 digits code number sent to you at',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${widget.phoneNumber}',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Container(
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      autoFocus: true,
                      obscureText: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        borderWidth: 1,
                        activeColor: ColorHelper.mainColor,
                        inactiveColor:  ColorHelper.mainColor,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.grey.shade100,
                        selectedColor: ColorHelper.mainColor,
                        selectedFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      onCompleted: (code) {
                        otpCode = code;
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                      },

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: CustomButton(
                      text: "Verify",
                      onPressed: (){
                        showProgressIndicator(context);
                        _login(context);
                      },
                    ),
                   /* child: CustomButton(
                      onPressed: () {

                      },
                      text: Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      width: 60,
                      height: 40,
                      radius: 5,
                    ),*/
                  ),
                ),
                _buildPhoneVerificationBloc(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
