import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features_exports.dart';
import '../../../../otp/presentation/view_model/manger/otp_cubit/otp_cubit.dart';

class TakePhone extends StatelessWidget {
   TakePhone({Key? key}) : super(key: key);


  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  TextEditingController _phoneController= TextEditingController() ;

  String phoneNumber =' ';




  Widget _buildIntroTexts (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your phone numbeer?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            "What is your phone numbeer to verify your account",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneFormField (){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8 ,vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: ColorHelper.lightGrey),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Text(
              _generateCountryFlag() + ' +20',
              style: TextStyle(
                fontSize:18,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 16,),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12 ,vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: ColorHelper.blue),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: TextFormField(
              controller: _phoneController,
              autofocus: true,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: InputDecoration( border: InputBorder.none, ),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value){
                if(value!.isEmpty){
                  return 'please enter your phone number !' ;
                }else if (value.length <11){
                  return 'too short for a phone number !';
                }
                return null ;
              },
              onSaved: (value){
                phoneNumber = value! ;
              },

            ),
          ),
        ),

      ],
    );
  }

  String _generateCountryFlag(){
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

   Widget buildPhoneSubmitedBlock() {
     return BlocListener<OtpCubit, OtpState>(
       listenWhen: (previous, current) {
         return previous != current;
       },
       listener: (context, state) {
         if (state is Loading) {
           return showProgressIndicator(context);
         }
         if (state is PhoneNumberSubmitted) {
           Navigator.pop(context);
           Navigator.pop(context);
           Navigator.of(context).push(
             MaterialPageRoute(builder: (context){
               return OtpView(phoneNumber: _phoneController.text);
             }
             ),);
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




   Future<void> _register(BuildContext context) async {
     if (!_phoneFormKey.currentState!.validate()) {
       Navigator.pop(context);
       return;
     } else {
       Navigator.pop(context);
       _phoneFormKey.currentState!.save();
       BlocProvider.of<OtpCubit>(context).submitPhoneNumber(_phoneController.text);
     }
   }


   void showProgressIndicator (BuildContext context){
     AlertDialog alertDialog = AlertDialog(
       backgroundColor: Colors.transparent,
       elevation: 0,
       content: Center(
         child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorHelper.mainColor),),
       ),
     );

     showDialog(
         barrierColor: Colors.white.withOpacity(0),
         barrierDismissible: false,
         context: context,
         builder: (context) => alertDialog);
   }

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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

            Form(
              key: _phoneFormKey,
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 30,vertical: _heightScreen*0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntroTexts(),
                    SizedBox(height: _heightScreen*0.06),
                    _buildPhoneFormField(),
                    SizedBox(height: _heightScreen*0.06,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: (){
                          showProgressIndicator(context);
                          _register(context);
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white ,fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(110, 50),
                          backgroundColor: ColorHelper.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    buildPhoneSubmitedBlock() ,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
