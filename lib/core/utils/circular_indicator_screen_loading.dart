import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core_exports.dart';

class CircularIndicatorScreenLoading extends StatelessWidget {
  const CircularIndicatorScreenLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    double _heightScreen = MediaQuery.of(context).size.height;
    return Container(
      height: _heightScreen,
      width: _widthScreen,
      color: ColorHelper.blackColor.withOpacity(0.3),
      child: Center(
        child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                //color: ColorHelper.whiteColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            )),
        /*child: Lottie.asset(
            "assets/svg/animation_loading_3.json"),*/
      ),
    );
  }
}
