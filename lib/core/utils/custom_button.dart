import 'package:flutter/material.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/core/constants/constants_exports.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
    Key? key,
     this.backgroundColor,
     this.heightButton,
     this.widthButton,
     this.elevation,
     this.textStyle,
     this.borderRadius,
     required this.onPressed,
     required this.text,
  }) : super(key: key);

  String text ;
   final VoidCallback onPressed;
  Color? backgroundColor ;
  double? heightButton ;
  double? widthButton ;
  double? elevation ;
  TextStyle? textStyle ;
   BorderRadiusGeometry? borderRadius ;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor ?? ColorHelper.mainColor,
          fixedSize: Size(
              widthButton?? MediaQuery.of(context).size.width,
              heightButton?? 55,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          ),
        ),

        child: Text(text,style: textStyle ,),
    );
  }
}
