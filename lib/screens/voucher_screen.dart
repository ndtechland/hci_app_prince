import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../models/VoucherData.dart';
import '../utils/datasource.dart';
import 'generatemovievoucher_screen.dart';

class VoucherLoginPage extends StatefulWidget {
  final Voucher? voucher;
  VoucherLoginPage({Key? key, this.voucher}) : super(key: key);

  @override
  _VoucherLoginPageState createState() => _VoucherLoginPageState();
}

class _VoucherLoginPageState extends State<VoucherLoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  TextEditingController _textUserNameController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  void loginUser(String name) async {
    //images/fci_images/cropped-Logo-HCi.png
    String url =
        "https://hci.ndinfotech.com/api/Vacationapi/MatchPassword?password=" +
            _textUserNameController.text.toString();
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      setState(() {
        _isLoading = false;
      });
      if (responseData['Status'] == 1) {
        if (widget.voucher != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GenerateMovieVoucherPage(voucher: widget.voucher!)));
        } else {
          _isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              :
              // await Future.delayed(Duration(seconds: 2));
              Navigator.popAndPushNamed(context, '/voucherregister_screen');
        }
      } else {
        Fluttertoast.showToast(
            msg: "Incorrect username or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey1,
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset('images/fci_images/cropped-Logo-HCi.png'),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: Text(
                        'Verify Password and generate password',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: TextFormField(
                  //     controller: _textUserNameController,
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Required';
                  //       } else {
                  //         return null;
                  //       }
                  //     },
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       labelText: 'Password',
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(4)),
                  //           borderSide:
                  //               BorderSide(width: 1, color: primaryColor)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(4)),
                  //           borderSide:
                  //               BorderSide(width: 1, color: primaryColor)),
                  //     ),
                  //     textInputAction: TextInputAction.next,
                  //   ),
                  // ),
                  ///
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _textUserNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock,
                              color: primaryColor), // Lock icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Increased border radius
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1.5, color: primaryColor),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16), // Adjust padding
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey1.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        loginUser(_textUserNameController.text);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something  ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      }

                      // if (widget.voucher != null) {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) =>
                      //           GenerateMovieVoucherPage(voucher: widget.voucher)));
                      // } else {
                      //   Navigator.popAndPushNamed(
                      //       context, '/voucherregister_screen');
                      // }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: 110,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              'Verify',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
