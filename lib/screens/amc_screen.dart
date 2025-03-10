import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/datasource.dart';

class AmcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'AMC Details',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                color: Colors.blue[900],
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: Text(
                          'Year',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.017),
                        )),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 1.5,
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Amount (Including GST)',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.height * 0.017),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.001),
                      child: Container(
                        height: 50,
                        color: Colors.blueGrey[200],
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                    child: Text(
                                  '1',
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.black,
                                    fontSize: size.height * 0.019,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              ),
                            ),
                            VerticalDivider(
                                color: Colors.white, thickness: 1.5, width: 20),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '₹ 20618',
                                      style: GoogleFonts.aBeeZee(
                                        color: Colors.black,
                                        fontSize: size.height * 0.019,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                      'In case of any due/over due of AMC/ Maintenance fee members will not be allowed to process any holidays')),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                      'Pay your entire AMC and avail special discount, gift hampers and more'))
            ],
          ),
        ),
      ),
    );
  }
}
