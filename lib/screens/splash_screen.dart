import 'package:flutter/material.dart';

import 'package:clothes_map/screens/main_screen/main_widget.dart';
import 'package:clothes_map/services/location.dart';
import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/styles.dart';
import 'package:clothes_map/utils/status_bar_color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    changeStatusBarColor(appPrimaryColor, false);
    UserInfo().getInfo();
    Location().findUserLocation();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => MainWidget(),
          transitionsBuilder: (context, animation1, animation2, child) =>
              ScaleTransition(
            scale: animation1,
            child: child,
          ),
          transitionDuration: Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      height: 816,
      width: 432,
      allowFontScaling: true,
    )..init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                child: Image.asset(
                  'assets/splash_logo.png',
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                tag: 'splash_logo',
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
