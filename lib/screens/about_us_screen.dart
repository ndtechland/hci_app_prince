import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/datasource.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20, left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About us ',
                    style: TextStyle(color: primaryColor, fontSize: 20,fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 120,
                  child: Divider(
                    color: primaryColor,
                    height: 10,
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Introduction',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500))),
              SizedBox(
                height: 20,
              ),
              Text(
                aboutUs,
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Programs and Offers',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(offerOne),
              SizedBox(
                height: 10,
              ),
              Text(offerTwo),
              SizedBox(
                height: 10,
              ),
              Text(offerThree),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Vision and Goals',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(vision)
            ],
          ),
        ),
      ),
    );
  }
}
