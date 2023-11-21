import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:abraj_al_buhaira_attendance_eng_ashraf/features/features_exports.dart';

class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
          (status) async{
        if (status == AnimationStatus.completed) {
          final token = await CacheHelper.getData(key: "token");
          final finger = await CacheHelper.getData(key: "finger");

          if(finger == "true"){
            FingerPrint().authAuth(context);
          }
          else{
            if (token != null) {
              Navigator.of(context).pushReplacement(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: AttendanceView(),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: Duration(milliseconds: 1500 ),
                ),
              );
            }
            else {
              Navigator.of(context).pushReplacement(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: LoginView(),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: Duration(milliseconds: 1500 ),
                ),
              );
            }
          }






          Timer(
            Duration(milliseconds: 200),
                () {
              scaleController.reset();
            },
          );
        }
      },
    );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(seconds: 4), () {
      setState(() {
        scaleController.forward();
      });
    });


  }

  @override
  void dispose() {
// TODO: implement dispose
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorHelper.mainColor,
      body: Center(
        child: DefaultTextStyle(
          style: TextStyleHelper.textStyle22,
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'ABRAJ  AL  BUHAIRA',
               // 'Abraj Al Buhaira',
                speed: Duration(milliseconds: 130),
              ),
            ],
            isRepeatingAnimation: false,
            repeatForever: false,
            displayFullTextOnTap: false,
          ),
        ),
      ),
    );
  }
}



// import 'dart:async';
// import 'package:abraj_al_buhaira_attendance/features/features_exports.dart';
// import 'package:flutter/material.dart';
//
//
// class SplashBody extends StatefulWidget {
//
//   @override
//   _SplashBodyState createState() => _SplashBodyState();
// }
//
// class _SplashBodyState extends State<SplashBody>
//     with TickerProviderStateMixin {
//   double _fontSize = 3;
//   double _containerSize = 1.5;
//   double _textOpacity = 0.0;
//   double _containerOpacity = 0.0;
//
//   late AnimationController _controller;
//   late Animation<double> animation1;
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 3));
//
//     animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
//         parent: _controller, curve: Curves.fastLinearToSlowEaseIn,))
//       ..addListener(() {
//         setState(() {
//           _textOpacity = 1.0;
//         });
//       });
//
//     _controller.forward();
//
//     Timer(Duration(seconds: 3), () {
//       setState(() {
//         _fontSize = 1.08;
//       });
//     });
//
//     Timer(Duration(seconds: 4), () {
//       setState(() {
//         _containerSize = 2;
//         _containerOpacity = 1;
//       });
//     });
//
//     Timer(Duration(seconds: 5000), () {
//       setState(() {
//         Navigator.pushReplacement(context, PageTransition(LoginView()));
//       });
//     });
//   }
//
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       // backgroundColor: Color(0xff302E96),
//       // backgroundColor: Color(0xff6666ff),
//       //backgroundColor: Colors.blueAccent,
//        backgroundColor: ColorHelper.mainColor,
//       body: Stack(
//         children: [
//           /*Image.asset("assets/images/background/background7.jpg",height: _height,fit: BoxFit.fill,),
//           Container(
//             height: _height,
//               width: _width,
//             decoration: BoxDecoration(
//               gradient: RadialGradient(
//                 radius: 2,
//                   colors:[
//                 Colors.black.withOpacity(0.1),
//                 Colors.black.withOpacity(0.6),
//                 Colors.black.withOpacity(0.9),
//
//               ]),
//             ),
//           ),*/
//           Column(
//             children: [
//               AnimatedContainer(
//                   duration: Duration(milliseconds: 2000),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   height: _height / _fontSize,
//
//               ),
//               AnimatedOpacity(
//                 duration: Duration(milliseconds: 1000),
//                 opacity: _textOpacity,
//                 child: Container(
//                   child: Text(
//                     'Abraj Al Buhaira',
//                     style: GoogleFonts.roboto(
//                       color: ColorHelper.whiteColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: animation1.value,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//          /* Center(
//             child: AnimatedOpacity(
//               duration: Duration(milliseconds: 1000),
//               curve: Curves.fastLinearToSlowEaseIn,
//               opacity: _containerOpacity,
//               child: AnimatedContainer(
//                   duration: Duration(milliseconds: 1000),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   *//*height: _width / _containerSize,
//                 width: _width / _containerSize,*//*
//                   height: 160,
//                   alignment: Alignment.center,
//                   decoration:  BoxDecoration(
//                     color: Colors.white.withOpacity(0.8),
//                     shape: BoxShape.circle,
//                     *//*boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: const Offset(0, 5),
//                       ),
//
//                     ],*//*
//                     //borderRadius: BorderRadius.circular(30),
//
//                   ),
//                   child: Image.asset('assets/images/abraj_al_buhaira-remove.png',fit: BoxFit.fill,
//                     // width: _width / _containerSize,
//                   )
//                 *//* child: Text(
//                   'YOUR APP\'S LOGO',
//                 ),*//*
//               ),
//             ),
//           ),*/
//         ],
//       ),
//     );
//   }
// }
//
// class PageTransition extends PageRouteBuilder {
//   final Widget page;
//
//   PageTransition(this.page)
//       : super(
//     pageBuilder: (context, animation, anotherAnimation) => page,
//     transitionDuration: Duration(milliseconds: 2000),
//     transitionsBuilder: (context, animation, anotherAnimation, child) {
//       animation = CurvedAnimation(
//         curve: Curves.fastLinearToSlowEaseIn,
//         parent: animation,
//       );
//       return Align(
//         alignment: Alignment.bottomCenter,
//         child: SizeTransition(
//           sizeFactor: animation,
//           child: page,
//           axisAlignment: 0,
//         ),
//       );
//     },
//   );
// }
//
// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         //brightness: Brightness.dark,
//         //backgroundColor: Color(0xff302E96),
//         backgroundColor: Color(0xff6666ff),
//         //backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//         title: Text(
//           'Abraj Al Buhaira',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }
