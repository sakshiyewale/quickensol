import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickensol/pages/sign_in_page.dart';
import 'package:quickensol/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: ColorsForApp.headingPageColor
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Text("QuickenSol",style: TextStyle(
              fontSize: 25.sp,fontWeight: FontWeight.w400,color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }
}
