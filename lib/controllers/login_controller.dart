// // import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class PhoneController extends GetxController {
//   var isLoading = false.obs;
//   var otpMessage = ''.obs;
//
//   Future<void> sendOtp(String mobileNumber) async {
//     isLoading.value = true;
//     final url = 'https://fcclub.co.in/api/Loginapi/Login';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'mobile': mobileNumber}),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       otpMessage.value = data['message'];
//     } else {
//       otpMessage.value = 'Failed to send OTP';
//     }
//     isLoading.value = false;
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';

var box = GetStorage();

class OtpController extends GetxController {
  var isSendingOtp = false.obs;
  var isVerifyingOtp = false.obs;
  var numMessage = ''.obs;
  var otpMessage = ''.obs;

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  Future<void> sendOtp(String mobileNumber) async {
    isSendingOtp.value = true;
    final url = 'https://hci.ndinfotech.com/api/Loginapi/Login'
        // 'https://fcclub.co.in/api/Loginapi/Login'
        //https://hci.ndinfotech.com/
        ;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': mobileNumber}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        numMessage.value = data['Message'] ?? 'OTP sent successfully';
        await setLogin(true, mobileNumber);
        //Get.to(OtpVerifyScreen());

        ///todo: navigate next screen....
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OtpVerifyScreen()));
        // Save login status

        if (data['status'] == 200) {
          await setLogin(true, mobileNumber); // Save login status
        }
      } else {
        numMessage.value = 'Failed to send OTP';
      }
    } catch (e) {
      numMessage.value = 'Error: ${e.toString()}';
    }
    isSendingOtp.value = false;
  }

  Future<void> verifyOtp(String mobileNumber, String otp) async {
    isVerifyingOtp.value = true;
    final url = 'https://hci.ndinfotech.com/api/Loginapi/MobileOtpVerify';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'Otp': otp}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        otpMessage.value = data['Message'] ?? 'OTP verified successfully';
        var userId = data['Id'];
        box.write("Id", userId);
        print("useeerrrIddd:$userId");
        await setLoginStatus(true, mobileNumber, data['Id']);
        print("iiiid:${data['Id']}"); // Save
        if (data['status'] == 200) {
          box.write("Id", userId);
          print("useeerrrIddd:$userId");
          await setLoginStatus(true, mobileNumber, data['Id']);
          print("iiiid:${data['Id']}"); // Save login status
        }
        Get.to(() => HomePage());
      } else {
        otpMessage.value = 'Failed to verify OTP';
      }
    } catch (e) {
      otpMessage.value = 'Error: ${e.toString()}';
    }
    isVerifyingOtp.value = false;
  }

  Future<void> setLoginStatus(
      bool loginStatus, String mobileNumber, int userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", loginStatus);
    sharedPreferences.setString("mobileNumber", mobileNumber);
    sharedPreferences.setInt("Id", userId);
    print("iiiidddd:$userId");
    print("loginStatus:$loginStatus");
    print("mobileNumber:$mobileNumber");
  }

  ///......///.......///........///......
  //
  // Future<void> setLoginStatus(
  //     bool loginStatus, int OTP, int userId) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool("isLoggedIn", loginStatus);
  //   sharedPreferences.setString("mobileNumber", OTP);
  //   sharedPreferences.setInt("Id", userId);
  //   print("iiiidddd:$userId");
  //   print("loginStatus:$loginStatus");
  //   print("mobileNumber:$mobileNumber");
  // }

  Future<void> setLogin(
    bool loginStatus,
    String mobileNumber,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", loginStatus);
    sharedPreferences.setString("mobileNumber", mobileNumber);
    print("loginStatus:$loginStatus");
    print("mobileNumber:$mobileNumber");
  }
}
