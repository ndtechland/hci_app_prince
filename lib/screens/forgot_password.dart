import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/datasource.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textEmailController = TextEditingController();
  TextEditingController _textMobileController = TextEditingController();
  bool _isLoading = false;

  void sendPassword() async {
    final String email = _textEmailController.text.toString();
    final String mobile = _textMobileController.text.toString();

    final Uri url =
        Uri.parse('https://hci.ndinfotech.com/api/passwordapi/ForgetPassword'
            '?Email=$email'
            '&Mobile=$mobile');

    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['Status'] == "1") {
        showSnackBar();
      } else {
        Fluttertoast.showToast(
          msg: "Invalid details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Change Password',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'required field';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'required field';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Mobile',
                    hintText: 'Registered  mobile no',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor))),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    sendPassword();
                  }
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: 200,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(left: 10),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Container()),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Password sent to registered number'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    ));
    final snackBarContent = SnackBar(
      content: Text("Password sent to registered number"),
    );
    //_scaffoldKey.currentState.showSnackBar(snackBarContent);
  }
}
