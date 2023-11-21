import 'package:flutter/material.dart';
import '../../../../../core/core_exports.dart';

class CustomDividerLine extends StatelessWidget {
  const CustomDividerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;

    double _widthItemsSelection = MediaQuery.of(context).size.width*0.57;
    return Column(
      children: [
        SizedBox(height: _heightScreen * 0.03),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1,
              width: _widthScreen*0.4,
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                      colors: [ColorHelper.whiteColor, ColorHelper.borderColor.withOpacity(0.4)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                  )
              ),
            ),
            Container(
              height: 1,
              width: _widthScreen*0.4,
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                      colors: [ColorHelper.whiteColor, ColorHelper.borderColor.withOpacity(0.4)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft
                  )
              ),
            ),

          ],
        ),
        SizedBox(height: _heightScreen * 0.02),*/
      ],
    );
  }
}
