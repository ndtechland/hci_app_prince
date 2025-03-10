import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/datasource.dart';

class DestinationWedding extends StatefulWidget {
  @override
  _DestinationWeddingState createState() => _DestinationWeddingState();
}

class _DestinationWeddingState extends State<DestinationWedding> {
  List _listImages = [];
  Future getDestinationWeddingImages() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://hci.ndinfotech.com/api/Destinationapi/DestinationWedding'), // Convert URL to Uri
    );
    if (response.statusCode == 200) {
      setState(() {
        _listImages = json.decode(response.body);
        if (_listImages.isEmpty) {
          Fluttertoast.showToast(
              msg: "No Images available",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Destination Wedding',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: _listImages.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            : ListView.builder(
                itemCount: _listImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 400,
                    child: Image.network(
                      IMAGE_BASE_URL + _listImages[index]['ImageDest'],
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ));
  }

  @override
  void initState() {
    super.initState();
    getDestinationWeddingImages();
  }
}
