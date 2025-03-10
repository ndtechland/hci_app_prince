import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  int? userId;
  List dataFinal = [];
  bool isLoading = true;

  void getPaymentHistory() async {
    var endPointUrl = "https://hci.ndinfotech.com/api/UserEmi/PaymentDetail";
    Map<String, String> queryParameters = {"Id": userId.toString()};

    String queryString = Uri(queryParameters: queryParameters).query;
    var requestUrl = endPointUrl + "?" + queryString;
    http.Response response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      setState(() {
        dataFinal = json.decode(response.body);
        isLoading = false;
      });
    } else {
      showToast("No data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Payment History',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: dataFinal.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              //color: Colors.blue.shade900,
              width: double.infinity,
              height: double.infinity,
              child: Card(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Payment Details :',
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        )),
                    Divider(
                      color: Colors.grey[400],
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Amount'))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                "₹ ${dataFinal[0]['Amount'].toString()}",
                                style: TextStyle(color: Colors.orange[700])))
                      ],
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Initial Payment'))),
                        Expanded(
                            flex: 1,
                            //"₹ ${dataFinal[0]['Amount'].toString()}",
                            //                                 style: TextStyle(color: Colors.orange[700])))
                            child: Text(
                                "₹ ${dataFinal[0]['InitialPayment'].toString()}",
                                style: TextStyle(color: Colors.orange[700])))
                      ],
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Total EMI'))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                "₹ ${dataFinal[0]['TotalEMI'].toString()}",
                                style: TextStyle(color: Colors.orange[700])))
                      ],
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Total Pay'))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                "₹ ${dataFinal[0]['TotalPay'].toString()}",
                                style: TextStyle(color: Colors.orange[700])))
                      ],
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Balance'))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "₹ ${dataFinal[0]['Balance'].toString()}",
                              style: TextStyle(color: Colors.orange[700]),
                            ))
                      ],
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: .5,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("Id")!;
      print("iddd:$userId");
    });

    getPaymentHistory();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
}
