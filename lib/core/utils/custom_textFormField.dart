import 'package:flutter/material.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/core/core_exports.dart';
import 'package:flutter/services.dart';


class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({
    Key? key,
     required this.hintText,
     this.hintStyle,
     this.textStyle,
     this.heightFilled,
     this.widthFilled,
     this.borderColor,
     this.focusBorderColor,
     this.enableFilled,
     this.enableBorder,
     this.backgroundFilled,
     this.prefixIcon,
     this.suffixIcon,
     this.sizePrefixIcon,
     this.sizeSuffixIcon,
     this.obscureText,
     this.textAlignVertical,
     this.keyboardType,
     this.autofocus,
     this.controller,
     this.validation,
     this.maxLength,
     this.inputFormatters,

  }) : super(key: key);

  final String hintText ;
  final TextStyle? hintStyle ;
  final TextStyle? textStyle ;
   final Color? borderColor ;
   final Color? focusBorderColor ;
   final bool? enableFilled ;
   final bool? enableBorder;
   final Color? backgroundFilled;
   final Widget? prefixIcon;
   final Widget? suffixIcon;
   final double? sizePrefixIcon;
   final double? sizeSuffixIcon;
   final bool? obscureText;
   final TextAlignVertical? textAlignVertical;
   final TextInputType? keyboardType;
   final bool? autofocus;
   final double? heightFilled ;
   final double? widthFilled;
   final int? maxLength;
   final TextEditingController? controller;
   final List<TextInputFormatter>? inputFormatters;
   final validation;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        filled: enableFilled ?? true,
        fillColor:backgroundFilled?? Color(0x0A000000),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
        prefixIconConstraints: BoxConstraints(
          maxHeight: (sizePrefixIcon!=null)?sizePrefixIcon!+25 :55*0.9,
          maxWidth: (sizePrefixIcon!=null)?sizePrefixIcon!+25 : 55*0.9,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: (sizeSuffixIcon!=null)?sizeSuffixIcon!+25 :55*0.9,
          maxWidth: (sizeSuffixIcon!=null)?sizeSuffixIcon!+25 : 55*0.9
        ),
        constraints: BoxConstraints(
          maxHeight: heightFilled ?? 55,
          maxWidth:  widthFilled ?? MediaQuery.of(context).size.width,

        ),
        //contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: ),
        enabledBorder: (enableBorder==true || enableBorder==null)? _buildOutlineBorder() :null,
        focusedBorder: (enableBorder==true || enableBorder==null)? _buildFocusedOutlineBorder():_buildFocusedUnderlineInputBorder(),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius:BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color:ColorHelper.redColor.shade300,
            width: 2,
           
          ),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius:BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color:ColorHelper.redColor.shade300,
            width: 1,


          ),
        ),
      ),
      style: textStyle,
      obscureText: obscureText?? false,
      textAlignVertical: textAlignVertical??TextAlignVertical.center,
      keyboardType:keyboardType ,
      autofocus:autofocus ?? false,
      inputFormatters: inputFormatters,
      maxLength: maxLength,

    );
  }



   OutlineInputBorder _buildOutlineBorder() {
     return  OutlineInputBorder(
       borderRadius:BorderRadius.all(Radius.circular(8.0)),
       borderSide: BorderSide(
         color: borderColor?? backgroundFilled?? Color(0x0A000000),
       ),
     );
   }


   OutlineInputBorder _buildFocusedOutlineBorder() {
     return OutlineInputBorder(
       borderRadius:BorderRadius.all(Radius.circular(8.0)),
       borderSide: BorderSide(
         width: 2,
         color: focusBorderColor ?? ColorHelper.mainColor,
       ),
     );
   }

   UnderlineInputBorder _buildFocusedUnderlineInputBorder() {
     return UnderlineInputBorder(
       borderSide: BorderSide(
         width: 2,
         color: focusBorderColor ?? ColorHelper.mainColor,
       ),
     );
   }
}



/*
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({
    Key? key,
     required this.hintText,
     this.textStyle,
     this.height,
     this.width,
     this.hintTextStyle,
     this.obscureText,
     this.textInputType,
     this.prefixWidget,
     this.suffixWidget,


   }) : super(key: key);

   TextStyle? textStyle ;
   TextStyle? hintTextStyle ;
   double? height;
   double? width;
   bool? obscureText;
   String hintText;
   TextInputType? textInputType ;
   Widget? prefixWidget ;
   Widget? suffixWidget ;

   double minusHeight=0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle??TextStyleHelper.textStyle12,
      cursorColor: ColorHelper.mainColor,
      obscureText: obscureText ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      textAlignVertical: TextAlignVertical.bottom,
      decoration:  InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleHelper.textStyle12.copyWith(color: ColorHelper.text2Color),
        prefixIcon:  Padding(
          padding: const EdgeInsets.only(left : 16,right: 10),
          child: prefixWidget,
        ),
        suffixIcon: suffixWidget,
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 48,
          maxWidth: 48,
        ),
        constraints: BoxConstraints(
          maxHeight: height??48,
          maxWidth: width?? double.infinity,

        ),
        // contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: (height==null || height!<= 48 )? 0: (height!-48)*2  ),
        enabledBorder: buildOutlineBorder(),
        focusedBorder: buildFocusedOutlineBorder(),


      ),
    );
  }
}
*/





