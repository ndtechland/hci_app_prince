import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpVerifyController extends GetxController {
  var isLoading = false.obs;
  var otpMessage = ''.obs;
  final TextEditingController otpController = TextEditingController();
  Future<void> verifyOtp(String mobileNumber, String otp) async {
    isLoading.value = true;
    final url = 'https://hci.ndinfotech.com/api/Loginapi/MobileOtpVerify';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Otp': otp}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      otpMessage.value = data['Message'];
    } else {
      otpMessage.value = 'Failed to verify OTP';
    }
    isLoading.value = false;
  }
}
