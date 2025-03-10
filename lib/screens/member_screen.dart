///
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../utils/datasource.dart';
//
// class MemberLoginPage extends StatefulWidget {
//   @override
//   _MemberLoginPageState createState() => _MemberLoginPageState();
// }
//
// class _MemberLoginPageState extends State<MemberLoginPage> {
//   @override
//   void initState() {
//     /// TODO: implement initState
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Set the status bar color
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: primaryColor, // Change this to your desired color
//     ));
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             margin: EdgeInsets.only(left: 0, right: 0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   SizedBox(
//                     height: 0,
//                   ),
//                   Image.asset('images/fci_images/cropped-Logo-HCi.png'
//                       //'images/logoheader.jpeg'
//                       ),
//                   SizedBox(
//                     height: 100,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 20, top: 10),
//                       child: Text(
//                         'Are you a member?',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.popAndPushNamed(
//                                 context, '/voucherlogin_screen');
//                           },
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: primaryColor,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5))),
//                               width: 80,
//                               height: 40,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                       child: Text(
//                                     'NO',
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 80,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             checkLoginStatus().then((isLoggedIn) => {
//                                   isLoggedIn
//                                       ? Navigator.popAndPushNamed(
//                                           context, '/home_screen')
//                                       : Navigator.popAndPushNamed(
//                                           context, '/phone_screen')
//                                   // Navigator.popAndPushNamed(
//                                   //             context, '/login_screen')
//                                 });
//                           },
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: primaryColor,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5))),
//                               width: 80,
//                               height: 40,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                       child: Text(
//                                     'YES',
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Future<bool> checkLoginStatus() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   bool isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
//   return isLoggedIn;
// }
///
///
///
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class MemberLoginPage extends StatefulWidget {
  @override
  _MemberLoginPageState createState() => _MemberLoginPageState();
}

class _MemberLoginPageState extends State<MemberLoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Background Image
          // Image.network(
          //   'https://plus.unsplash.com/premium_photo-1694475346400-abd6aa79eb96?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDkzfHx8ZW58MHx8fHx8'
          //   //'https://plus.unsplash.com/premium_photo-1664303906236-057fc3eb9fc3?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
          //   // 'https://plus.unsplash.com/premium_photo-1687996107530-8e565c9b3690?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDI0NXx8fGVufDB8fHx8fA%3D%3D'
          //
          //   ///'https://plus.unsplash.com/premium_photo-1663126957077-164cb0178e68?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5OXx8fGVufDB8fHx8fA%3D%3D'
          //   //'https://plus.unsplash.com/premium_photo-1682377521552-49d35c2c9704?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExMXx8fGVufDB8fHx8fA%3D%3D'
          //   //'https://plus.unsplash.com/premium_photo-1661962769148-fbe587e60fb8?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEwNnx8fGVufDB8fHx8fA%3D%3D'
          //   //'https://plus.unsplash.com/premium_photo-1692217764140-4f8db35b9f76?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEwOHx8fGVufDB8fHx8fA%3D%3D'
          //   //'https://plus.unsplash.com/premium_photo-1675745329954-9639d3b74bbf?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
          //   //'https://images.unsplash.com/photo-1462926703708-44ab9e271d97?q=80&w=2127&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
          //   //'https://images.unsplash.com/photo-1528543606781-2f6e6857f318?q=80&w=2001&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
          //   , // Replace with your travel-themed image
          //   fit: BoxFit.cover,
          //
          //   ///todo:......////todo:......///todo:..........///todo:.....
          // ),
          SafeArea(
            child: Column(
              children: [
                Spacer(flex: 2),
                // Logo
                Image.asset(
                  'images/fci_images/cropped-Logo-HCi.png', // Replace with a travel-themed logo
                  height: 120,
                ),
                SizedBox(height: 30),
                // Heading
                Text(
                  'Are you a member?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 20),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton('NO', primaryColor, '/voucherlogin_screen'),
                    SizedBox(width: 20),
                    _buildButton('YES', primaryColor2, '/phone_screen'),
                  ],
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, String route) {
    return GestureDetector(
      onTap: () async {
        if (text == "YES") {
          bool isLoggedIn = await checkLoginStatus();
          route = isLoggedIn ? '/home_screen' : '/phone_screen';
        }
        Navigator.popAndPushNamed(context, route);
      },
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(2, 2))
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> checkLoginStatus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool("isLoggedIn") ?? false;
}
