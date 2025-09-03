
import 'package:first_app/Admin_module/AdminLogInPage.dart';
import 'package:first_app/SelectLogInType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget{


  @override
 _SplashScreenState createState() =>_SplashScreenState();
  
}

class _SplashScreenState  extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SelectLogInType()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Lottie.asset(
              'assets/animations/attendence.json',
              width: 200,
              height: 200,
              repeat: true,
              reverse: false,
              animate: true

          ),
        ),
      ),
    );
  }
}