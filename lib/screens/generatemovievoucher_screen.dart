import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../models/VoucherData.dart';

class GenerateMovieVoucherPage extends StatefulWidget {
  final Voucher voucher;
  GenerateMovieVoucherPage({Key? key, required this.voucher}) : super(key: key);

  @override
  GenerateMovieVoucherPageState createState() =>
      GenerateMovieVoucherPageState();
}

class GenerateMovieVoucherPageState extends State<GenerateMovieVoucherPage> {
  File? _imageFile;
  static final _controller = ScreenshotController();

  @override
  void initState() {
    super.initState();

    ///TODO: from here we have option prince........

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Screenshot(
              controller: _controller,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 400,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 20, right: 10),
                                        //alignment: Alignment.topCenter,
                                        width: 300,
                                        child: Image.asset(
                                            'images/hotel_logo.png')),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 0, left: 35),
                                      //alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Voucher No - ' +
                                            ' ' +
                                            widget.voucher.sequenceNo,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  if (widget.voucher.isChecked)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 40),
                                        child: Text(
                                          'Movies voucher - Valid for 1 month',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.orange,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 20),
                                      child: Text(
                                        'Name: ' + '  ' + widget.voucher.name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Text(
                                        'Phone/Mobile: ' +
                                            '  ' +
                                            widget.voucher.mobile,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Text(
                                        'Email: ' +
                                            '  ' +
                                            widget.voucher.emailId,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 20),
                                      child: Text(
                                        'Terms and Conditions for Offers:',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Text(
                                        '1- This gift voucher is valid for weekdays only.',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '2- This offer is valid for couple only.',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '3- This offer to be booked 5 days in advance',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '4- Only one voucher is valid at a time and non transferable',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '5- This offer cannot be redeemed for cash or cheque',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  Align(
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 20, right: 10),
                                        height: 100,
                                        child: Image.asset('images/movie.png')),
                                  ),
                                  Align(
                                    child: Container(
                                      color: Colors.red,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          right: 10,
                                          left: 10,
                                          bottom: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'MOVIE VOUCHER',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'HCI VAcation',
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        '0120- 4250389',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        // https://hci.ndinfotech.com/
                                        //https://www.fcclub.co.in/api/
                                        'www.hcihospitality.in',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'G-14, 2nd Floor, Sector-10',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Gautam Buddh Nagar , Noida-201301',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      //alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.orange,
                        // padding: EdgeInsets.only(
                        //     top: 5, left: 5, bottom: 5, right: 5),
                        // margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            'To redeem the voucher or any queries mail : voucher@hcihospitality.in',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton.extended(
            onPressed: () {
              // _takeScreenshotandShare3();
              _takeScreenshotandShare();
            },
            label: const Text('Share'),
            icon: const Icon(
              Icons.share,
              color: Colors.white,
              size: 25,
            ),
            backgroundColor: Colors.orange,
            // child:
            //     Icon(
            //       Icons.share,
            //       color: Colors.white,
            //       size: 25,
            //     ),
            //
            // backgroundColor: Colors.orange,
            // elevation: 5,
          ),
          SizedBox(
            height: 10,
          ),
        ]));
  }

  ///TODO: from here flutter share......new implementation in flutter...KP

  ///from here we have to new thing to sare the image and screen shoot. kprince abhi br...........

  // _takeScreenshotandShare() async {
  //   _imageFile = null;
  //   _controller
  //       .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
  //       .then((Uint8List? image) async {
  //     setState(() {
  //       _imageFile = File.fromRawPath(image);
  //     });
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     Uint8List pngBytes = _imageFile.readAsBytesSync();
  //     File imgFile = new File('$directory/screenshot.png');
  //     imgFile.writeAsBytes(pngBytes);
  //     print("File Saved to Gallery");
  //     await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }
  ///

  // _takeScreenshotandShare() async {
  //   _imageFile = null; // This is now valid
  //   _controller
  //       .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
  //       .then((Uint8List? image) async {
  //     setState(() {
  //       _imageFile = File.fromRawPath(image!);
  //     });
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     Uint8List pngBytes =
  //         _imageFile!.readAsBytesSync(); // Use ! to assert non-null
  //     String filePath = '$directory/screenshot.png';
  //     File imgFile = new File(filePath);
  //     imgFile.writeAsBytes(pngBytes);
  //     print("File Saved to Gallery");
  //     await FlutterShare.shareFile(
  //       title: "Hello!",
  //       text: "Gift Voucher",
  //       filePath: filePath,
  //     );
  //     //await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  Future<void> _takeScreenshotandShare() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String localPath =
          '${directory.path}/${DateTime.now().toIso8601String()}.png';

      final Uint8List? imageBytes = await _controller.capture();
      if (imageBytes == null) {
        print("Screenshot capture failed.");
        return;
      }

      final File imageFile = File(localPath);
      await imageFile.writeAsBytes(imageBytes);

      await Share.shareXFiles([XFile(imageFile.path)],
          text: 'Here is your movie voucher');
    } catch (e) {
      print("Error sharing: $e");
    }
  }

  ///Todo:

  // _takeScreenshotandShare() async {
  //   _imageFile = null;
  //   _controller
  //       .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
  //       .then((File image) async {
  //     setState(() {
  //       _imageFile = image;
  //     });
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     Uint8List pngBytes = _imageFile.readAsBytesSync();
  //     File imgFile = new File('$directory/screenshot.png');
  //     imgFile.writeAsBytes(pngBytes);
  //     print("File Saved to Gallery");
  //     await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }
}
