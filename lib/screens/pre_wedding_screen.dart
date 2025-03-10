import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/datasource.dart';

class PreWeddingScreen extends StatefulWidget {
  @override
  _PreWeddingScreenState createState() => _PreWeddingScreenState();
}

class _PreWeddingScreenState extends State<PreWeddingScreen> {
  List _listImages = [];
  Future getPreWeddingImages() async {
    http.Response response = await http.get(
        Uri.parse('https://hci.ndinfotech.com/api/preWeddingapi/preWedding'));
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
          title: Text(
            'Pre Wedding',
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
                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1)),
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
    getPreWeddingImages();
  }
}
