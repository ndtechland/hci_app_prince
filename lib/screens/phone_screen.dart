import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../utils/datasource.dart';
import 'otp_screen.dart';

class PhoneScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'images/fci_images/cropped-Logo-HCi.png',
                    height: 120,
                  ),
                  const SizedBox(height: 30),

                  // Mobile Number Input
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: controller.mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Enter Mobile Number',
                        hintText: 'Enter mobile number',
                        prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Send OTP Button
                  Obx(() {
                    return controller.isSendingOtp.value
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: width * 0.6,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                final mobileNumber =
                                    controller.mobileController.text;
                                if (mobileNumber.isNotEmpty) {
                                  await controller.sendOtp(mobileNumber);
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtpVerifyScreen()),
                                  );
                                } else {
                                  Get.snackbar('Error',
                                      'Please enter a valid mobile number');
                                }
                              },
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                  }),

                  const SizedBox(height: 20),

                  // OTP Status Message
                  Obx(() {
                    return Text(
                      controller.numMessage.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: controller.numMessage.value.contains('Error')
                            ? Colors.red
                            : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
