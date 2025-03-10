import 'package:flutter/material.dart';

import '../utils/datasource.dart';

class ThanksDialog extends StatelessWidget {
  final BuildContext mcontext;
  ThanksDialog(this.mcontext);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 300,
            width: 250,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Dear member your booking request is forwarded to concerned department and you will get updated soon at your registered number or \n mail Id: reservation@futurechoicehospitality.com \n Feel free to contact our customer care at 9654282869 for any assistance',
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(mcontext).pop();
                      },
                      child: Container(
                          width: 180,
                          height: 45,
                          color: primaryColor,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Thank You',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Image.asset('images/tick.png'),
            width: 60,
            height: 60,
            top: -30,
          )
        ],
      ),
    );
  }
}
