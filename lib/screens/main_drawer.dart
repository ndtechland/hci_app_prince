import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String userName = "";
  void showBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet((context) => Container(
          child: Text('hello'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 183,
              width: double.infinity,
              color: primaryColor,
              child: Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ///........///........///......///........
                        //CallLoader.loader();
                        await Future.delayed(Duration(seconds: 2));
                        await Navigator.popAndPushNamed(context, '/profile');
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        margin: EdgeInsets.only(top: 50, bottom: 10),
                        decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/fci_images/cropped-Logo-HCi.png"),
                                fit: BoxFit.fill)),
                        // child: Image.asset('images/logoheader.jpeg'
                        //     //'images/images.jpg'
                        //     ),
                      ),
                    ),
                    Text(userName,
                        style: GoogleFonts.roboto(
                            color: Colors.blue.shade900,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/profile');
              },
              leading: Icon(Icons.person, size: 30),
              title: Text(
                'Profile Details',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/vacations');
              },
              leading: Image.asset(
                'images/vacations.png',
                width: 30,
                height: 30,
              ),
              title: Text(
                'My Vacations',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/resorts_screen');
              },
              leading: Image.asset(
                'images/resort.png',
                width: 30,
                height: 30,
              ),
              title: Text(
                'Associated Resorts',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/gallery_screen');
              },
              leading: Icon(Icons.image, size: 30),
              title: Text(
                'Gallery',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/paymentHistory');
              },
              leading: Icon(
                Icons.attach_money,
                size: 30,
              ),
              title: Text('Payment History'),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/emi_details');
              },
              leading: Icon(
                Icons.payment,
                size: 30,
              ),
              title: Text('E.M.I Details'),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.popAndPushNamed(context, '/amc_screen');
            //   },
            //   leading: Image.asset(
            //     'images/contract.png',
            //     width: 30,
            //     height: 30,
            //   ),
            //   title: Text(
            //     'AMC',
            //     style: TextStyle(fontSize: 14),
            //   ),
            // ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/book_holiday');
              },
              leading: Image.asset(
                'images/vacations.png',
                width: 30,
                height: 30,
              ),
              title: Text(
                'Book a holiday',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/events');
              },
              leading: Image.asset(
                'images/calendar.png',
                width: 28,
                height: 28,
              ),
              title: Text(
                'Events',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                ///share();
              },
              leading: Icon(Icons.share, size: 28),
              title: Text(
                'Refer a friend',
                style: TextStyle(fontSize: 14),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.popAndPushNamed(context, '/change_password');
            //   },
            //   leading: Icon(Icons.lock, size: 30),
            //   title: Text(
            //     'Change Password',
            //     style: TextStyle(fontSize: 14),
            //   ),
            // ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/contact_us');
              },
              leading: Icon(Icons.contact_phone, size: 30),
              title: Text(
                'Contact Us',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, '/about_us');
              },
              leading: Icon(Icons.info, size: 30),
              title: Text(
                'About Us',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
              ),
              title: Text(
                'LogOut',
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                //showBottomSheet(context);
                showDialog<void>(
                  context: context,
                  // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Log-Out'),
                      content: Text('Are you sure you want to log-out of app?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss alert dialog
                          },
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () async {
                            logOutUser(context);

                            /// Navigator.of(dialogContext).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                size: 30,
              ),
              title: Text(
                'Delete Account',
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                //showBottomSheet(context);
                showDialog<void>(
                  context: context,
                  // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Delete Account'),
                      content: Text(
                          'Are you sure you want to delete your account ?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss alert dialog
                          },
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss alert dialog
                          },
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  void getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString("userName")!;
    });
  }
}

// Future<void> share() async {
//   String? linkUrl;
//   if (Platform.isAndroid) {
//     linkUrl =
//         'https://play.google.com/store/apps/details?id=com.ndtechland.fch.fch_club_new24';
//   } else if (Platform.isIOS) {
//     linkUrl =
//         'https://apps.apple.com/us/app/future-choice-hospitality/id6670314847';
//     // 'https://apps.apple.com/us/app/future-choice-hospitality/id1590494810';
//   }
//
//   await FlutterShare.share(
//       title: 'Future Choice Hospitality',
//       text: 'Hi, this is the Future Choice Hospitality App link.',
//       linkUrl: linkUrl ?? '',
//       chooserTitle: 'Future Choice Hospitality');
// }

void logOutUser(BuildContext context) async {
  Navigator.pushNamedAndRemoveUntil(
      context, "/memberlogin_screen", (r) => false);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
}

Future<void> share() async {
  String? linkUrl;
  if (Platform.isAndroid) {
    linkUrl =
        'https://play.google.com/store/apps/details?id=com.ndtechland.fch.fch_club_new24';
  } else if (Platform.isIOS) {
    linkUrl =
        'https://apps.apple.com/us/app/future-choice-hospitality/id6670314847';
  }

  Share.share('Hi, this is the Future Choice Hospitality App link.\n$linkUrl');
}
