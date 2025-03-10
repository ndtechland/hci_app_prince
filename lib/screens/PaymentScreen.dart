import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
//import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ///todo: march 5 2025,
  //final _razorpay = Razorpay();
  List listProfileData = [];
  int? userId;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  void getProfileData() async {
    var endPointUrl =
        "https://hci.ndinfotech.com/api/Myprofileapi/MyProfileGet";
    //print(userId.toString());
    Map<String, String> queryParamete = {
      'id': userId.toString(),
    };
    String queryString = Uri(queryParameters: queryParamete).query;
    var requestUrl = endPointUrl + '?' + queryString;
    // var uri =
    // Uri.https('https://www.futurechoiceclub.com', '/api/Myprofileapi/MyProfileGet', queryParameters);
    http.Response response = await http.get(Uri.parse(requestUrl));
    print("okurl ${requestUrl}");
    //print(requestUrl);
    //print('https://www.futurechoiceclub.com/api/Myprofileapi/MyProfileGet?id=$userId');
    //print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        listProfileData = json.decode(response.body);
      });
    } else {
      Fluttertoast.showToast(
          msg: "No data available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    String AMCamount = '';
    double paymentAmount = 0.0;

    if (listProfileData != null && listProfileData.isNotEmpty) {
      AMCamount = listProfileData[0]['Amc'].toString();
      double amount = double.tryParse(AMCamount) ?? 0.0;
      // Multiply by 100 if necessary
      paymentAmount = amount * 100;
    } else {
      /////.....................
      Fluttertoast.showToast(
          msg: "Loading....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      // Handle the case where listProfileData is null or empty
      // For example, you could set a default paymentAmount or display an error message
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Payment Options',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage(
            //       "images/paymentbackground.jpg",
            //       //"https://images.unsplash.com/photo-1571715268998-d6e79bed5fc9?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHx8"
            //       //"https://images.unsplash.com/photo-1599202875854-23b7cd490ff4?q=80&w=2382&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            //       // "https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            //     ),
            //     fit: BoxFit.fill)
            ),
        margin: EdgeInsets.only(top: 0),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                //Spacer(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          showPaymentDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: primaryColor2,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: tempColor)),
                          margin: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/exchange.gif',
                                height: 150,
                                width: 150,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Exchange',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              Text('Choose amount'),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          startPayment(paymentAmount);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: primaryColor2,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: tempColor)),
                          margin: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/amc.jpeg',
                                height: 150,
                                width: 150,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Amc(Including GST)',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "₹ ${listProfileData.isNotEmpty ? listProfileData[0]['Amc'].toString() : 'Loading'}"

                                  // "₹ ${listProfileData[0]['Amc']}".toString() ??
                                  //     Loading.toString(),
                                  ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/emi_details');
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: primaryColor2,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: tempColor)),
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/emi.png',
                              height: 150,
                              width: 140,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'E.M.I',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showPaymentDialog();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primaryColor2,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: tempColor)),
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/other.png',
                              height: 150,
                              width: 130,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Other',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Text('Choose amount'),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserId();

    ///commenmt on 5 march 2025...kp
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("Id");
      print("profile${userId}");
    });
    getProfileData();
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeeds
  //   print('Success');
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   print(response.code.toString());
  //   print('errrada');
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet was selected
  //   print(response.walletName);
  // }

  startPayment(double amount) {
    if (listProfileData != null && listProfileData.isNotEmpty) {
      var options = {
        'key': 'rzp_live_eiaOxQ8zHwxdX4eee',
        'amount': amount,
        'name': listProfileData[0]['Name'],
        'description': 'Payment to FutureChoiceCLub',
        'prefill': {
          'contact': listProfileData[0]['Mobile'],
          'email': listProfileData[0]['EMail'],
        }
      };

      try {
        ///todo comment on 5 march 2025..
        /// _razorpay.open(options);
      } catch (e) {
        print('error is $e');
      }
    } else {
      // Handle the case when listProfileData is null or empty
      // For example, show an error message or handle it according to your app's logic
      print('listProfileData is null or empty');
    }
  }

  // startPayment(double amount) {
  //   var options = {
  //     'key': 'rzp_live_eiaOxQ8zHwxdX4',
  //     'amount': amount,
  //     'name': listProfileData[0]['Name'],
  //     //'Future Choice CLub',
  //     'description': 'Payment to FutureChoiceCLub',
  //     'prefill': {
  //       'contact': listProfileData[0]['Mobile'],
  //       'email': listProfileData[0]['EMail'],
  //     }
  //   };
  //
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     print('error is $e');
  //   }
  // }

  void showPaymentDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 220,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Provide amount')),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: primaryColor)),
                        border: OutlineInputBorder()),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        startPayment(
                            double.parse(amountController.text.toString()) *
                                100);
                        Navigator.pop(dialogContext);
                      }
                    },
                    child: Container(
                      width: 160,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 20),
                      color: primaryColor,
                      child: Text(
                        'Pay Now',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
