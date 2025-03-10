import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

import '../utils/datasource.dart';
import '../widgets/home_menu.dart';
import 'main_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        //backgroundColor: Color(oxFFC6600),
        title: Text(
          'HCI Hospitality',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 220,
                child: AnotherCarousel(
                  dotSize: 5.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.grey,
                  indicatorBgPadding: 10,
                  dotBgColor: Colors.transparent,
                  dotVerticalPadding: 5.0,
                  images: [
                    Image.asset(
                      'images/fci_images/1.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset('images/fci_images/2.png', fit: BoxFit.cover),
                    Image.asset('images/fci_images/3.png', fit: BoxFit.cover),
                    Image.asset('images/fci_images/4.png', fit: BoxFit.cover),
                    Image.asset('images/fci_images/5.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              HomeMenu()
            ],
          ),
        ),
      ),
    );
  }
}
