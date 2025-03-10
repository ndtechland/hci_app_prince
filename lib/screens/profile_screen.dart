import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/datasource.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List listProfileData = [];
  int? userId;

  Future<void> getProfileData() async {
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
    Size size = MediaQuery.of(context).size;
    // Extract the 'Amount' value from the first element of the list
    ///String amountAsString = listProfileData[0]["Amount"].toString();

// Parse the string into an integer
    /// var amount = double.parse("${amountAsString}").toInt();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Profile Details',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: listProfileData.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              color: primaryColor2,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('images/profile_fcc_back.png'),
              //         fit: BoxFit.fill)),
              child: SingleChildScrollView(
                //rtrtr:yryryyryr.....jhjh....
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Container(
                      width: size.width * 0.77,
                      margin: EdgeInsets.all(0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Basic Info',
                                  style: GoogleFonts.alatsi(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * 0.04),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Full Name :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      listProfileData[0]['Name'],
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueAccent[400],
                                          fontSize: size.height * 0.014),
                                      // fontSize: 13
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Email :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['EMail'],
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Phone :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['Mobile'],
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Address :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['Address'],
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.77,
                      margin: EdgeInsets.all(0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Membership Details',
                                  style: GoogleFonts.alatsi(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * 0.04),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Type :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['TypeOfMembership'],
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Membership Id :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['MemberShipId'],
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Amc :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "₹ ${listProfileData[0]['Amc']} (Including GST)",
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                        // style: TextStyle(
                                        //   color: Colors.grey[600],
                                        //   fontSize: 13,
                                        // ),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Tenure :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${listProfileData[0]['Tenure']} Years",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Date of joining :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['DOjoining'],
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Occupancy :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['Occumancy'],
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Amount :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        // "₹ ${amount}",
                                        //var amount = double.parse(amountAsString).toInt()
                                        "₹ ${listProfileData[0]['Amount'].toString()}",
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Remaining Vacations :',
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.014),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        listProfileData[0]['Nights']
                                                .toString() +
                                            " Nights and " +
                                            listProfileData[0]['Days']
                                                .toString() +
                                            " Days",
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent[400],
                                            fontSize: size.height * 0.014),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.77,
                      //height: size.height * 0.12,
                      margin: EdgeInsets.all(0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Special Offer',
                                style: GoogleFonts.alatsi(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.04),
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
                              Text(
                                listProfileData[0]['SpecialOffer'],
                                maxLines: 5,
                                style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueAccent[400],
                                    fontSize: size.height * 0.014),
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: .5,
                              ),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("Id");
      print("profile${userId}");
    });
    if (userId != null) {
      await getProfileData(); // Call after userId is set
    }
  }
}
