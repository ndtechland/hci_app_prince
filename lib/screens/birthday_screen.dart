import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/datasource.dart';

class BirthdayScreen extends StatefulWidget {
  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  List _listImages = [];
  Future getBirthDayImages() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://hci.ndinfotech.com/api/Birthdayeventapi/BirthdayEvent'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _listImages = json.decode(response.body);
        if (_listImages.isEmpty) {
          Fluttertoast.showToast(
            msg: "No Images available",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Birthdays',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: _listImages == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            : ListView.builder(
                itemCount: _listImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 400,
                      child: Image.network(
                        IMAGE_BASE_URL + _listImages[index]['ImageDest'],
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ));
  }

  @override
  void initState() {
    super.initState();
    getBirthDayImages();
  }
}
