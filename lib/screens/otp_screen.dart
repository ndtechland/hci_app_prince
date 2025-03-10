///
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
//
// import '../controllers/login_controller.dart';
//
// class OtpVerifyScreen extends StatefulWidget {
//   @override
//   State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
// }
//
// class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
//   final OtpController controller = Get.put(OtpController());
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Image.asset('images/logoheader.jpeg'),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   "Enter OTP",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: SizedBox(
//                     width: width / 2,
//                     child: Pinput(
//                       length: 4,
//                       controller: controller.otpController,
//                       keyboardType: TextInputType.number,
//                       autofocus: true,
//                       showCursor: true,
//                       onChanged: (pin) {
//                         if (pin.length == 4) {
//                           FocusScope.of(context).unfocus();
//                         }
//                       },
//                       defaultPinTheme: PinTheme(
//                         width: 60,
//                         height: 60,
//                         textStyle: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Obx(() {
//                   if (controller.isVerifyingOtp.value) {
//                     return Center(child: CircularProgressIndicator());
//                   } else {
//                     return Container(
//                       height: 50,
//                       width: 120,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepOrange,
//                           // Replace with your primary color
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () async {
//                           final otp = controller.otpController.text;
//                           final mobileNumber = controller.mobileController.text;
//                           if (otp.isNotEmpty) {
//                             await controller.verifyOtp(mobileNumber, otp);
//                             if (controller.otpMessage.value
//                                 .contains('Success')) {
//                               Navigator.pushNamedAndRemoveUntil(
//                                   context, '/home_screen', (route) => false);
//                             } else {
//                               Get.snackbar(
//                                   'Error', controller.otpMessage.value);
//                             }
//                           } else {
//                             Get.snackbar('Error', 'Please enter OTP');
//                           }
//                         },
//                         child: Text(
//                           'Verify OTP',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     );
//                   }
//                 }),
//                 SizedBox(height: 20),
//                 Obx(() {
//                   return Text(
//                     controller.otpMessage.value,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: controller.otpMessage.value.contains('Error')
//                           ? Colors.red
//                           : Colors.green,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
///

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/login_controller.dart';
import '../utils/datasource.dart';

class OtpVerifyScreen extends StatefulWidget {
  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'images/fci_images/cropped-Logo-HCi.png',
                  height: 120,
                ),
                SizedBox(height: 40),

                // Title
                Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                // OTP Input
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
                  child: Pinput(
                    length: 4,
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    showCursor: true,
                    onChanged: (pin) {
                      if (pin.length == 4) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    defaultPinTheme: PinTheme(
                      width: 55,
                      height: 55,
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Verify Button
                Obx(() {
                  return controller.isVerifyingOtp.value
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: width * 0.6,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              final otp = controller.otpController.text;
                              final mobileNumber =
                                  controller.mobileController.text;
                              if (otp.isNotEmpty) {
                                await controller.verifyOtp(mobileNumber, otp);
                                if (controller.otpMessage.value
                                    .contains('Success')) {
                                  // Navigator.pushNamedAndRemoveUntil(context,
                                  //     '/home_screen', (route) => false);
                                } else {
                                  Get.snackbar(
                                      'Error', controller.otpMessage.value);
                                }
                              } else {
                                Get.snackbar('Error', 'Please enter OTP');
                              }
                            },
                            child: Text(
                              'Verify OTP',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                }),

                SizedBox(height: 20),

                // OTP Status Message
                Obx(() {
                  return Text(
                    controller.otpMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: controller.otpMessage.value.contains('Error')
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
    );
  }
}
