import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';
import '../widgets/thanks_dialog.dart';

class BookHoliday extends StatefulWidget {
  @override
  _BookHolidayState createState() => _BookHolidayState();
}

class _BookHolidayState extends State<BookHoliday> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late int userId;

  List locationList = []; // Initialize with an empty list
  String? selectedLocation; // Allow null values

  // List hotelList = []; // Initialize with an empty list
  // String? selectedHotel; // Allow null values

  DateTime selectedDate = DateTime.now();
  DateTime checkOutDate = DateTime.now();
  TextEditingController _textNoOfNightsController = TextEditingController();
  TextEditingController _textNoOfAdultsController = TextEditingController();
  TextEditingController _textNoOfChildController = TextEditingController();
  TextEditingController _textMembershipIdController = TextEditingController();
  TextEditingController _textPhoneController = TextEditingController();
  TextEditingController _textEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserId();
    getLocations();
  }

  Future getLocations() async {
    http.Response response = await http
        .get(Uri.parse("https://hci.ndinfotech.com/api/BookHoliday/AllCity"));
    if (response.statusCode == 200) {
      setState(() {
        locationList = json.decode(response.body);
        // Set default value for selectedLocation if locationList is not empty
        if (locationList.isNotEmpty) {
          selectedLocation = locationList[0]['DesinationName'];
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  // Future getHotel(String locationId) async {
  //   var url =
  //       'https://fcclub.co.in/api/BookHoliday/GetPlaceByLocationId?LocationId=$locationId';
  //   http.Response response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       hotelList = json.decode(response.body);
  //       print("url:${url}");
  //       print("hotelList:${hotelList}");
  //       // Set default value for selectedHotel if hotelList is not empty
  //       if (hotelList.isNotEmpty) {
  //         selectedHotel = hotelList[0]['PlaceName'];
  //       }
  //     });
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Something went wrong",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1);
  //   }
  // }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _checkOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != checkOutDate)
      setState(() {
        checkOutDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: locationList.isEmpty // Check if locationList is empty
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : SafeArea(
              child: Container(
                color: primaryColor,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: size.height * 0.3,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/fci_images/cropped-Logo-HCi.png"),
                                fit: BoxFit.fitWidth)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.00,
                              horizontal: size.width * 0.028),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: size.width * 0.075,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black26,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Colors.white,
                                    size: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                        ),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 30, left: 20),
                                  width: double.infinity,
                                  child: Text(
                                    'Search Hotel',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 20, top: 5),
                                  child: Text(
                                    'Find hotel as you need with demand',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Select City',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                  color: textInPutBackground,
                                  width: double.infinity,
                                  height: 50,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: selectedLocation,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(),
                                    hint: Text('Select city'),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLocation = value;
                                        // selectedHotel = null;

                                        String locationId = locationList
                                            .firstWhere((element) =>
                                                element['DesinationName'] ==
                                                value)['Id']
                                            .toString();

                                        // getHotel(locationId);
                                      });
                                    },
                                    items: locationList.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item['DesinationName'],
                                        child:
                                            Text(item['DesinationName'] ?? " "),
                                      );
                                    }).toList(),
                                  )),
                              // Container(
                              //     width: double.infinity,
                              //     margin: EdgeInsets.only(top: 20, left: 20),
                              //     child: Text(
                              //       'Select Hotel',
                              //       style: TextStyle(
                              //           color: Colors.black, fontSize: 12),
                              //       textAlign: TextAlign.start,
                              //     )),
                              // Container(
                              //     color: textInPutBackground,
                              //     width: double.infinity,
                              //     height: 50,
                              //     padding: EdgeInsets.all(10),
                              //     margin: EdgeInsets.only(
                              //         top: 10, left: 20, right: 20),
                              //     child: DropdownButton<String>(
                              //       icon: Icon(Icons.arrow_drop_down),
                              //       iconSize: 36,
                              //       isExpanded: true,
                              //       value: selectedHotel,
                              //       style: TextStyle(color: Colors.black),
                              //       underline: Container(),
                              //       hint: Text('Select Hotel'),
                              //       onChanged: (value) {
                              //         setState(() {
                              //           selectedHotel = value;
                              //         });
                              //       },
                              //       items: hotelList.map((item) {
                              //         return DropdownMenuItem<String>(
                              //             value: item['PlaceName'] ?? " ",
                              //             child: Text(item['PlaceName'] ?? ""));
                              //       }).toList(),
                              //     )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Check In',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  decoration:
                                      BoxDecoration(color: textInPutBackground),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${selectedDate.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Icon(Icons.calendar_today,
                                            color: Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Check Out',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  _checkOutDate(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  decoration:
                                      BoxDecoration(color: textInPutBackground),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${checkOutDate.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Icon(Icons.calendar_month_sharp,
                                            color: Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //     width: double.infinity,
                              //     margin: EdgeInsets.only(top: 20, left: 20),
                              //     child: Text(
                              //       'No of Nights',
                              //       style: TextStyle(
                              //           color: Colors.black, fontSize: 12),
                              //       textAlign: TextAlign.start,
                              //     )),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //       top: 10, left: 20, right: 20),
                              //   decoration:
                              //       BoxDecoration(color: textInPutBackground),
                              //   child: TextFormField(
                              //     keyboardType: TextInputType.number,
                              //     controller: _textNoOfNightsController,
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //     ),
                              //     cursorColor: primaryColor,
                              //     decoration: InputDecoration(
                              //       contentPadding:
                              //           EdgeInsets.symmetric(horizontal: 15),
                              //       hintText: 'Enter No Of Nights',
                              //       hintStyle:
                              //           TextStyle(color: Colors.grey.shade400),
                              //       border: InputBorder.none,
                              //     ),
                              //     validator: (value) {
                              //       if (value!.isEmpty) {
                              //         return "Enter No Of Nights";
                              //       }
                              //     },
                              //   ),
                              // ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'No of Adults',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration:
                                    BoxDecoration(color: textInPutBackground),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _textNoOfAdultsController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    hintText: 'Enter No Of Adults',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter No Of Adults";
                                    }
                                  },
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'No of Child',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration:
                                    BoxDecoration(color: textInPutBackground),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _textNoOfChildController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    hintText: 'Enter No Of Child',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter No Of Child";
                                    }
                                  },
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Phone Number',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration:
                                    BoxDecoration(color: textInPutBackground),
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                        10), //n is maximum number of characters you want in textfield
                                  ],
                                  keyboardType: TextInputType.number,
                                  //maxLength: 10,
                                  controller: _textPhoneController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    hintText: 'Enter Phone Number',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Phone Number";
                                    }
                                  },
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration:
                                    BoxDecoration(color: textInPutBackground),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (v) {
                                    String pattern =
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                    RegExp regExp = new RegExp(pattern);
                                    if (v == "") {
                                      return "Enter Your Email";
                                    } else if (!regExp.hasMatch(v!)) {
                                      return 'Invalid Email Id';
                                    } else {
                                      return null;
                                    }
                                  },
                                  // keyboardType: TextInputType.number,
                                  controller: _textEmailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    hintText: 'Enter Email Id',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none,
                                  ),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter Email Id";
                                  //   }
                                  // },
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    // Perform the booking process
                                    if (selectedLocation != null) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      bookHoliday(context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Select location please",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1);
                                    }
                                  }
                                },
                                child: Text('Submit'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: primaryColor,
                                  minimumSize: Size(size.width * 0.8, 50),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
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

  void bookHoliday(BuildContext context) async {
    Map<String, String> data = {
      'UserId': userId.toString(),
      'City': selectedLocation!,
      // 'PlaceName': selectedHotel!,
      // 'NoofNights': _textNoOfNightsController.text.toString(),
      'NoofAdults': _textNoOfAdultsController.text.toString(),
      'Noofchild': _textNoOfChildController.text.toString(),
      'CheckinDate': selectedDate.toString(),
      'CheckOutDate': checkOutDate.toString(),
      'Phone': _textPhoneController.text.toString(),
      'Email': _textEmailController.text.toString(),
      // 'MemberShipId': _textMembershipIdController.text.toString(),
    };

    String url = "https://hci.ndinfotech.com/api/BookHoliday/GetHoliday";
    http.Response response =
        await http.post(Uri.parse(url), body: data); // Use Uri.parse(url)

    print(response.body);
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      print("Response Data: ${response.body}");
      print("Request Data: $data");

      if (responseData['Status'] == 1) {
        setState(() {
          _isLoading = false;
        });
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return ThanksDialog(context);
          },
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Something went wronggggg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('Id') ?? 0;
  }

// void bookHoliday(BuildContext context) async {
  //   Map data = {
  //     'City': selectedLocation,
  //     'PlaceName': selectedHotel,
  //     'NoofNights': _textNoOfNightsController.text.toString(),
  //     'NoofAdults': _textNoOfAdultsController.text.toString(),
  //     'Noofchild': _textNoOfChildController.text.toString(),
  //     'CheckinDate': selectedDate.toString(),
  //     'UserId': userId.toString(),
  //     'MemberShipId': _textMembershipIdController.text.toString(),
  //     //"adadadd"
  //   };
  //   String url = "https://fcclub.co.in/api/BookHoliday/GetHoliday";
  //   http.Response response = await http.post(url, body: data);
  //   print(response.body);
  //   print("okosdcsc: ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     Map responseData = json.decode(response.body);
  //     print("okosdcsc: ${response.body}");
  //     print("okosdcsczxxxz: $data");
  //
  //     if (responseData['Status'] == 1) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext dialogContext) {
  //           return ThanksDialog(context);
  //         },
  //       );
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Something went wrong",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1);
  //   }
  // }

  // void getLocationId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String id = sharedPreferences.getString("Id");
  //   if (id != null) {
  //     setState(() {
  //       locationId = id;
  //     });
  //   } else {
  //     // Handle the case where the value is not found or null
  //     // For example, set a default value
  //     setState(() {
  //       locationId = "${224}";
  //
  //       /// "okok"; // Replace "default_value" with your desired default value
  //       print("okokolocation: ${locationId}");
  //     });
  //   }
  // }

  // void getLocationId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     locationId = sharedPreferences.getString("Id");
  //   });
  // }
}
