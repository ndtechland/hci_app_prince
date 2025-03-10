import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class FeedBackScreen extends StatefulWidget {
  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  bool _isLoading = false;
  late int userId;
  TextEditingController feedbackController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  void postFeedback() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://hci.ndinfotech.com/api/Vacationapi/GetVaccation'), // Convert URL to Uri

        //'https://fcclub.co.in/api/Vacationapi/GetVaccation',
        body: {
          'id': userId.toString(),
          'Feedback': feedbackController.text.toString()
        });
    print(response.body);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['Status'] == 1) {
        setState(() {
          _isLoading = false;
          showSnackBar();
          feedbackController.text = '';
        });
      } else {
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Provide Feedback',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('images/feedback_image.png'),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'required field';
                    }
                  },
                  controller: feedbackController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Provide feedback here',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor)),
                  ),
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
                      postFeedback();
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
                            'Post Feedback',
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : Container()),
                          )
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
    );
  }

  void showSnackBar() {
    final content = SnackBar(
      content: Text("Feedback Posted Successfully"),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('snackBarContent'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    ));
    //_scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("userId")!;
    });
  }
}
