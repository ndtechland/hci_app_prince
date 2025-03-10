import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Timer(Duration(seconds: 2), () {
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerifyScreen()));
      Navigator.popAndPushNamed(context, '/memberlogin_screen');

      // checkLoginStatus().then((isLoggedIn) => {
      //       isLoggedIn
      //           ? Navigator.popAndPushNamed(context, '/home_screen')
      //           : Navigator.popAndPushNamed(context, '/login_screen')
      //     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/fci_images/cropped-Logo-HCi.png'
            //'images/logoheader.jpeg'
            ),
      ),
    );
  }
}

// Future<bool> checkLoginStatus() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   bool isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
//   return isLoggedIn;
// }
