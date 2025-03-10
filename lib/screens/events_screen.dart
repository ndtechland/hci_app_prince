import 'package:flutter/material.dart';

import '../utils/datasource.dart';

class EventsScreen extends StatefulWidget {
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final Uri _url = Uri.parse('https://1m6m.app.link/j7j8oLQD6Cb/');
    // Future<void> _launchUrl() async {
    //   if (!await launchUrl(_url)) {
    //     throw 'Could not launch $_url';
    //   }
    // }

    return Scaffold(
      //backgroundColor: Colors.blueAccent.shade700,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Events',
          style: TextStyle(
              color: Colors.white,
              fontSize: size.height * 0.03,
              fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            // GestureDetector(
            //     onTap: () {
            //       Navigator.pushNamed(context, '/preWedding');
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Image.asset(
            //         'images/pre_wedding.png',
            //         height: 130,
            //       ),
            //     )),
            // GestureDetector(
            //     onTap: () {
            //       Navigator.pushNamed(context, '/birthday_screen');
            //     },
            //     child: Image.asset('images/birthday.png')),
            // GestureDetector(
            //     onTap: () {
            //       Navigator.pushNamed(context, '/destinationWedding');
            //     },
            //     child: Image.asset('images/destination_wedding.png')),
            // GestureDetector(
            //     onTap: () {
            //       // _launchUrl();
            //       // Get.to(WebViewPswebsite());
            //       print("clickioscscsc");
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => WebViewEasydinner()),
            //       );
            //       // Navigator.pushNamed(context, '/WebViewEasydinner');
            //     },
            //     child: Image.asset('images/easydinner.jpeg'))
          ],
        ),
      ),
    );
  }
}
