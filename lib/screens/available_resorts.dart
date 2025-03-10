import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/Resorts.dart';
import '../utils/datasource.dart';
import 'hotel_details.dart';

class AvailableResorts extends StatefulWidget {
  @override
  _AvailableResortsState createState() => _AvailableResortsState();
}

class _AvailableResortsState extends State<AvailableResorts> {
  List<Resorts> resorts = [];
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getResorts().then((value) {
      setState(() {
        resorts = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Available Resorts',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : resorts.isEmpty
              ? Center(
                  child: Text(
                    'No resorts available',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: resorts.length,
                  itemBuilder: (context, index) {
                    Resorts resort = resorts[index];

                    return Container(
                      margin: EdgeInsets.all(0),
                      child: Card(
                        child: ListTile(
                          trailing: Icon(Icons.arrow_circle_right),
                          title: Text(
                            resort.desinationName ?? 'Unknown Destination',
                            style: GoogleFonts.aBeeZee(
                                fontSize: size.width * 0.043,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade800),
                          ),
                          subtitle: Text(
                            resort.placeName ?? 'Unknown Place',
                            style: GoogleFonts.aBeeZee(
                                fontSize: size.width * 0.033,
                                color: Colors.green.shade800),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    HotelDetails(resorts: resort)));
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

Future<List<Resorts>> getResorts() async {
  String url =
      "https://hci.ndinfotech.com/api/AssociateResort/GetAssociateResort";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    final List<Resorts> resorts =
        jsonResponse.map((data) => Resorts.fromJson(data)).toList();
    return resorts;
  } else {
    return <Resorts>[];
  }
}
