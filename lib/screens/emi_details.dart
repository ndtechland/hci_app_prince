import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

///import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class EmiDetails extends StatefulWidget {
  @override
  _EmiDetailsState createState() => _EmiDetailsState();
}

class _EmiDetailsState extends State<EmiDetails> {
  List listProfileData = [];

  ///todo: comment on 5 march 2025.......

  //final _razorPay = Razorpay();
  int? userId;
  bool isLoading = true;
  List dataFinal = [];
  int? emiId;
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
    http.Response response = await http.get(
        //      Uri.parse('https://fcclub.co.in/api/Destinationapi/DestinationWedding'), // Convert URL to Uri
        Uri.parse(requestUrl));
    print("okurl ${requestUrl}");
    //print(requestUrl);
    //print('https://www.futurechoiceclub.com/api/Myprofileapi/MyProfileGet?id=$userId');
    //print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        listProfileData = json.decode(response.body);
      });
    } else {
      // Fluttertoast.showToast(
      //     msg: "",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1);
    }
  }

  void updateEmiData() async {
    var endpointUrl = "https://hci.ndinfotech.com/api/UserEmi/EmiPay";
    Map<String, String> queryParameter = {"Id": emiId.toString()};
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + "?" + queryString;
    http.Response response = await http.get(Uri.parse(requestUrl));
    print("rUrl:$requestUrl");
    if (response.statusCode == 200) {
      Map responseBody = json.decode(response.body);
      if (responseBody['Status'] == 1) {
        showToast("EMI updated successfully");
        getEmiDetails();
      }
    } else {
      showToast("Can't update Emi Data");
    }
  }

  void getEmiDetails() async {
    var endPointUrl = "https://hci.ndinfotech.com/api/UserEmi/EmiDetails";
    Map<String, String> queryParameters = {"Id": userId.toString()};
    String queryString = Uri(queryParameters: queryParameters).query;
    var requestUrl = endPointUrl + "?" + queryString;
    http.Response response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      Map responseBody = json.decode(response.body);
      if (responseBody['Status'] == 1) {
        setState(() {
          dataFinal = responseBody['Data'];
        });
      } else {
        showToast("No data available");
      }
    } else {
      showToast("No data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //  backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'EMI Details',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: dataFinal == null
          ? FutureBuilder(
              future: Future.delayed(Duration(seconds: 2)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text('Data Not Found'),
                  );
                }
              },
            )
          : dataFinal.isEmpty
              ? Center(
                  child: Text('No data available'),
                )
              : Container(
                  width: double.infinity,
                  // height: 70,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Text(
                                        'Amount',
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.redAccent),
                                      ),
                                      Text(
                                        "(Including GST)",
                                        style: TextStyle(
                                          fontSize: 7,
                                        ),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text('Due Date',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo.shade900,
                                          fontSize: 15))),
                              Expanded(
                                  flex: 1,
                                  child: Text('Status',
                                      style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.orange.shade900,
                                      ))),
                              Expanded(flex: 1, child: Text(''))
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataFinal.length,
                          itemBuilder: (context, index) {
                            return (Card(
                              child: Container(
                                height: 70,
                                width: double.infinity,
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "    ₹ ${dataFinal[index]['InstallmentAmount'].toString()}",
                                      //  +
                                      // " ₹",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    Expanded(
                                      child: Text(
                                          dataFinal[index]['InstallmentDate']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Expanded(
                                      child: dataFinal[index]['IsPaid']
                                          ? Text(
                                              'Paid',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : Text('Pending',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600)),
                                    ),
                                    Expanded(
                                      child: !dataFinal[index]['IsPaid']
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  emiId =
                                                      dataFinal[index]['Id'];
                                                });
                                                startPayment(double.parse(
                                                    (dataFinal[index][
                                                            'InstallmentAmount'])
                                                        .toString()));
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    'Pay Now',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  )),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                'Paid',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          })
                    ],
                  ),
                ),
    );
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("Id");
    });

    getEmiDetails();
    getProfileData();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getProfileData();

    ///todo: comment on 5 march 2025.......

    // _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  ///todo: comment on 5 march 2025.......
  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeeds
  //   //print('Success');
  //   showToast("Payment Successful");
  // }
  ///
  ///todo: comment on 5 march 2025.......

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   print(response.code.toString());
  //   //print('errrada');
  //   showToast("Payment failed");
  // }
  ///todo: comment on 5 march 2025.......
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet was selected
  //   print(response.walletName);
  // }

  startPayment(double amount) {
    print(amount);
    var options = {
      'key': 'rzp_live_eiaOxQ8zHwxdX4ewee',
      'amount': (amount * 100).toInt(),
      'name': listProfileData[0]['Name'],
      //'Future Choice CLub',
      'description': 'Payment to HCI',
      'prefill': {
        'contact': listProfileData[0]['Mobile'],
        'email': listProfileData[0]['EMail'],
      }
    };

    try {
      ///todo: comment on 5 march 2025.......
      // _razorPay.open(options);
    } catch (e) {
      print('error is $e');
    }
  }
}
