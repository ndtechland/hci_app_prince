import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';
import '../widgets/vacations_list.dart';

class VacationsScreen extends StatefulWidget {
  @override
  _VacationsScreenState createState() => _VacationsScreenState();
}

class _VacationsScreenState extends State<VacationsScreen> {
  Map vacationsData = {}; // Initialize with an empty map
  int? userId; // Make userId nullable

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getTenureDetails() async {
    if (userId == null) return; // Return if userId is null

    var endPointUrl = "https://hci.ndinfotech.com/api/BookHoliday/GetAllTaner";
    String requestUrl = "$endPointUrl?userId=$userId";
    //"$userId";
    print("requestUrl: $requestUrl");

    try {
      http.Response response = await http.get(Uri.parse(requestUrl));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        Map responseData = json.decode(response.body);
        if (responseData['Status'] == 1) {
          setState(() {
            vacationsData = responseData;
          });
        } else {
          Fluttertoast.showToast(
              msg: "NO data found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } catch (e) {
      print("Exception: $e");
      Fluttertoast.showToast(
          msg: "Exception occurred",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  Future<void> debugSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String mobileNumber =
        sharedPreferences.getString("mobileNumber") ?? 'Not found';
    bool isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
    int userId = sharedPreferences.getInt("Id") ?? -1;
    print("Debug SharedPreferences:");
    print("Mobile Number: $mobileNumber");
    print("Is Logged In: $isLoggedIn");
    print("User ID: $userId");
  }

  Future<void> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("Id");
      print("userId:$userId");
    });
    await debugSharedPreferences();

    if (userId != null) {
      await getTenureDetails(); // Call after userId is set
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'My Vacations',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: vacationsData.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : Container(
              child: ListView.builder(
                itemCount:
                    int.tryParse(vacationsData['Tenure']?.toString() ?? '0') ??
                        0,
                itemBuilder: (context, index) {
                  return VacationListItem(
                    index,
                    getDate(vacationsData['DOjoining'] ?? ''),
                    int.tryParse(vacationsData['Tenure']?.toString() ?? '0') ??
                        0, // Handle null or invalid values here
                    vacationsData['Days'] ?? '',
                    vacationsData['Nights'] ?? '',
                  );
                },
              ),
            ),
    );
  }

  String getDate(String date) {
    String finalMonth = "";
    List<String> dateList = [];

    if (date.contains('/')) {
      dateList = date.split('/');
    } else if (date.contains('-')) {
      dateList = date.split('-');
    }

    if (dateList.length < 3) {
      return date; // Return the original date if it's not properly formatted
    }

    switch (dateList[1]) {
      case "1":
      case "01":
        finalMonth = "Jan";
        break;
      case "2":
      case "02":
        finalMonth = "Feb";
        break;
      case "3":
      case "03":
        finalMonth = "Mar";
        break;
      case "4":
      case "04":
        finalMonth = "Apr";
        break;
      case "5":
      case "05":
        finalMonth = "May";
        break;
      case "6":
      case "06":
        finalMonth = "Jun";
        break;
      case "7":
      case "07":
        finalMonth = "Jul";
        break;
      case "8":
      case "08":
        finalMonth = "Aug";
        break;
      case "9":
      case "09":
        finalMonth = "Sep";
        break;
      case "10":
        finalMonth = "Oct";
        break;
      case "11":
        finalMonth = "Nov";
        break;
      case "12":
        finalMonth = "Dec";
        break;
    }

    return dateList[0] + " " + finalMonth + " " + dateList[2];
  }

  Future<int> checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt("Id") ?? 0;
    return userId;
  }
}
