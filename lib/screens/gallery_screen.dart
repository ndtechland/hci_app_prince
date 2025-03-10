import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/datasource.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List _listImages = [];

  Future getGalleryImages() async {
    http.Response response = await http
        .get(Uri.parse("https://hci.ndinfotech.com/api/BookHoliday/AllImag"));
    if (response.statusCode == 200) {
      setState(() {
        _listImages = json.decode(response.body);
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Gallery',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: _listImages.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ))
          : ListView.builder(
              itemCount: _listImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // decoration: ,
                    //height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.network(
                        IMAGE_BASE_URL + _listImages[index]['ImageName'],
                        width: double.infinity,
                        //height: 400,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  @override
  void initState() {
    super.initState();
    getGalleryImages();
  }
}
