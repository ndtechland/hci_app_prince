import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../utils/datasource.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mail Us Any Issue At',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              //https://hci.ndinfotech.com/
              'reservation@hcihospitality.com',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Or give us a call at ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '0120-4546037',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  //https://hci.ndinfotech.com/
                  urlLauncher.launch('mailto:reservation@hci.com');
                },
                child: Image.asset(
                  'images/email.png',
                  height: 50,
                  width: 250,
                )),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  urlLauncher.launch('tel://0120-4546086');
                },
                child: Image.asset(
                  'images/call_now.png',
                  height: 50,
                  width: 200,
                ))
          ],
        ),
      ),
    );
  }
}
