import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hcivacation/screens/PaymentScreen.dart';
import 'package:hcivacation/screens/about_us_screen.dart';
import 'package:hcivacation/screens/amc_screen.dart';
import 'package:hcivacation/screens/available_resorts.dart';
import 'package:hcivacation/screens/birthday_screen.dart';
import 'package:hcivacation/screens/book_holiday_screen.dart';
import 'package:hcivacation/screens/change_password.dart';
import 'package:hcivacation/screens/contact_us_screen.dart';
import 'package:hcivacation/screens/destination_wedding_screen.dart';
import 'package:hcivacation/screens/emi_details.dart';
import 'package:hcivacation/screens/events_screen.dart';
import 'package:hcivacation/screens/feedback_screen.dart';
import 'package:hcivacation/screens/forgot_password.dart';
import 'package:hcivacation/screens/gallery_screen.dart';
import 'package:hcivacation/screens/generatevoucher_screen.dart';
import 'package:hcivacation/screens/home_screen.dart';
import 'package:hcivacation/screens/login_screen.dart';
import 'package:hcivacation/screens/member_screen.dart';
import 'package:hcivacation/screens/payment_history.dart';
import 'package:hcivacation/screens/phone_screen.dart';
import 'package:hcivacation/screens/pre_wedding_screen.dart';
import 'package:hcivacation/screens/profile_screen.dart';
import 'package:hcivacation/screens/splash_screen.dart';
import 'package:hcivacation/screens/vacations_screen.dart';
import 'package:hcivacation/screens/voucher_screen.dart';
import 'package:hcivacation/screens/voucherregister_screen.dart';
import 'package:hcivacation/utils/datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Override for handling self-signed certificates
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

///todo: edited by kumar prince till 1 july 2023...

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //bool isLoggedIn = await checkLoginStatus();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Circular', primaryColor: primaryColor),
    routes: {
      //'/': (ctx) => isLoggedIn ? HomePage() : LoginPage(),
      '/': (ctx) => SplashScreen(),
      '/memberlogin_screen': (ctx) => MemberLoginPage(),
      '/voucherlogin_screen': (ctx) => VoucherLoginPage(),
      '/voucherregister_screen': (ctx) => VoucherRegisterPage(),
      '/generatevoucher_screen': (ctx) => GenerateVoucherPage(),
      '/phone_screen': (ctx) => PhoneScreen(),

      '/login_screen': (ctx) => LoginPage(),
      '/home_screen': (ctx) => HomePage(),
      '/resorts_screen': (ctx) => AvailableResorts(),
      '/book_holiday': (ctx) => BookHoliday(),
      '/forgot_password': (ctx) => ForgotPassword(),
      '/change_password': (ctx) => ChangePassword(),
      '/amc_screen': (ctx) => AmcScreen(),
      '/gallery_screen': (ctx) => GalleryScreen(),
      '/about_us': (ctx) => AboutUs(),
      '/contact_us': (ctx) => ContactUs(),
      '/events': (ctx) => EventsScreen(),
      '/preWedding': (ctx) => PreWeddingScreen(),
      '/birthday_screen': (ctx) => BirthdayScreen(),
      '/destinationWedding': (ctx) => DestinationWedding(),
      '/feedback_screen': (ctx) => FeedBackScreen(),
      '/vacations': (ctx) => VacationsScreen(),
      '/payment': (ctx) => PaymentScreen(),
      '/profile': (ctx) => ProfileScreen(),
      '/paymentHistory': (ctx) => PaymentHistory(),
      '/emi_details': (ctx) => EmiDetails()
    },
  ));
}

// kumar prince........29 August  2024 after dropdown changed..latest
/// 2025..this is original code for development...hci
///todo: kumar prince.......again .5 march 2025  created new  it's working ios as well as android also.
///latest new
