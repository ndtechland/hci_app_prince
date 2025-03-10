import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcivacation/screens/voucher_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:share_plus/share_plus.dart';

import '../models/VoucherData.dart';
import '../utils/datasource.dart';

class GenerateVoucherPage extends StatefulWidget {
  final Voucher? voucher;
  GenerateVoucherPage({Key? key, this.voucher}) : super(key: key);

  //static GlobalKey previewContainer = new GlobalKey();

  @override
  GenerateVoucherPageState createState() => GenerateVoucherPageState();
}

class GenerateVoucherPageState extends State<GenerateVoucherPage> {
  File? _imageFile;
  static final _controller = ScreenshotController();
  GlobalKey screenshotKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    ///from here we have orientation the page..............
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Scaffold(
        key: screenshotKey,
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
                            flex: 1,
                            child: Container(
                                alignment: Alignment.topLeft,
                                width: 160,
                                child: Image.asset('images/ribbon.png')),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  Align(
                                    child: Container(
                                      //width: 100,
                                      margin: EdgeInsets.only(left: 5, top: 10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Gift Voucher',
                                        //arizonia this is font
                                        style: GoogleFonts.acme(
                                            letterSpacing: 3.0,
                                            fontSize: 32,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      //width: 100,
                                      margin: EdgeInsets.only(left: 5, top: 10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'This gift voucher entitle you for 3 Nights 4 days accommodation only for 2 adults and 2 children(below 5 years) at Holiday destination detailed and offered in this Voucher',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic),
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
                                            EdgeInsets.only(top: 20, right: 0),
                                        alignment: Alignment.topCenter,
                                        height: 90,
                                        width: 200,
                                        child: Image.asset(
                                          'images/fci_images/cropped-Logo-HCi.png',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Align(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Voucher No - ' +
                                            ' ' +
                                            widget.voucher!.sequenceNo,
                                        style: TextStyle(
                                            fontSize: 14,
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
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Name: ' + '  ' + widget.voucher!.name,
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Phone/Mobile: ' +
                                    '  ' +
                                    widget.voucher!.mobile,
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Email: ' + '  ' + widget.voucher!.emailId,
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 50),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  //alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Choice of Location : ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Align(
                                  //alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      '1:' + ' ' + widget.voucher!.choiceDate1,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Align(
                                  //alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      '2:' + ' ' + widget.voucher!.choiceDate2,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Align(
                                  //alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      '3:' + ' ' + widget.voucher!.choiceDate3,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Issued By: ' + '  ' + widget.voucher!.issuedBy,
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Date of issue:' +
                                    '  ' +
                                    widget.voucher!.issueDate.substring(0, 10),
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'See details',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '1. Voucher is for accommodation only for 3 Nights/ 4 days for 2 adults and 2 children(below 5 years )only and valid for 12 months from the date of issue.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '2. The gift voucher is valid for one time use and at one location only . Resort listed in this voucher may change without any prior information.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '3. One month advance notice is required to avail this voucher . Fill in three choices of your Vacation and mail this voucher to voucher@fcihospitality.com',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '4. Once the holiday has been confirmed, the booking can\'t be cancelled or modified',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '5. Utility charges 5999/- applicable will be paid by the voucher registration at the time of reservation.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '6. This voucher cannot be used during the Christmas, New Year , Black-out dates and peak season.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              //margin: EdgeInsets.only(bottom: 20),
                              child: Text(
                                '7. This voucher cannot be clubbed with any other offer and Voucher bearer can redeem only one voucher at a time .',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(
                                '8. Voucher not changeable in cash .',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
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
              _controller
                  .capture(delay: Duration(milliseconds: 10))
                  .then((capturedImage) async {
                ShowCapturedWidget(context, capturedImage!);
                _takeScreenshotandShare1(screenshotKey);
              }).catchError((onError) {
                print(onError);
              });
            },
            label: const Text(
              'Share',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.share,
              color: Colors.white,
              size: 25,
            ),
            backgroundColor: primaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          if (widget.voucher!.isChecked)
            SizedBox(
              height: 30,
              width: 200,
              child: FloatingActionButton(
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VoucherLoginPage(voucher: widget.voucher))),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.white,
                elevation: 5,
              ),
            ),
        ]),
      ),
    );
  }

  ///TODO: corrected by... abhshek bro.......
  // _takeScreenshotandShare1() async {
  //   try {
  //     // Capture the screenshot
  //     Uint8List? image = await _controller.capture(
  //         delay: Duration(milliseconds: 10), pixelRatio: 2.0);
  //
  //     if (image != null) {
  //       String? directory;
  //       // Get the external storage directory (publicly accessible)
  //       if (Platform.isAndroid) {
  //         directory = (await getApplicationDocumentsDirectory())?.path;
  //       } else if (Platform.isIOS) {
  //         directory = (await getApplicationDocumentsDirectory()).path;
  //       }
  //       //final directory = (await getExternalStorageDirectory())?.path;
  //
  //       if (directory != null) {
  //         // Create a file path
  //         String filePath = '$directory/screenshot.png';
  //
  //         // Write the image data to a file
  //         File imgFile = File(filePath);
  //         await imgFile.writeAsBytes(image);
  //
  //         print("File Saved to $filePath");
  //
  //         // Share the file using flutter_share
  //         await Share.shareXFiles([filePath], text: "Gift Voucher");
  //         // await FlutterShare.shareFile(
  //         //   title: 'Future Choice Hospitality',
  //         //   text: 'Gift Voucher',
  //         //   filePath: filePath,
  //         // );
  //       } else {
  //         print("Error: External storage directory not found");
  //       }
  //     } else {
  //       print("Image capture failed");
  //     }
  //   } catch (e) {
  //     print("onError: $e");
  //   }
  // }

  ///...
  Future<void> _takeScreenshotandShare1(GlobalKey screenshotKey) async {
    try {
      RenderRepaintBoundary? boundary = screenshotKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        print("Error: Boundary is null");
        return;
      }

      // Convert the widget into an image
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print("Error: ByteData is null");
        return;
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Get directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/screenshot.png';

      // Save the image
      File imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);

      print("File Saved to: $filePath");

      // Open Share Option
      await Share.shareXFiles([XFile(filePath)], text: "Gift Voucher");
    } catch (e) {
      print("Error: $e");
    }
  }
}

Future<dynamic> ShowCapturedWidget(
    BuildContext context, Uint8List capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      // appBar: AppBar(
      //   title: Text("Gift Voucher"),
      //   backgroundColor: primaryColor,
      // ),
      body: SafeArea(
        child: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    ),
  );
}

///

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart'; // Ensure you have the correct import
//
// import '../models/VoucherData.dart';
//
// class GenerateVoucherPage extends StatefulWidget {
//   final Voucher? voucher;
//   GenerateVoucherPage({Key? key, this.voucher}) : super(key: key);
//
//   @override
//   GenerateVoucherPageState createState() => GenerateVoucherPageState();
// }
//
// class GenerateVoucherPageState extends State<GenerateVoucherPage> {
//   File? _imageFile;
//   static final _controller = ScreenshotController();
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SingleChildScrollView(
//           child: Screenshot(
//             controller: _controller,
//             child: Container(
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   // Your UI code (voucher display details, etc.)
//                   // Skipping the layout code here as it remains the same
//                   // Refer to your original code for widget structure
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton:
//           Column(mainAxisAlignment: MainAxisAlignment.end, children: [
//         FloatingActionButton.extended(
//           onPressed: () {
//             _controller
//                 .capture(delay: Duration(milliseconds: 10))
//                 .then((capturedImage) async {
//               ShowCapturedWidget(context, capturedImage!);
//               _takeScreenshotandShare1();
//             }).catchError((onError) {
//               print(onError);
//             });
//           },
//           label: const Text(
//             'Share',
//             style: TextStyle(color: Colors.white),
//           ),
//           icon: const Icon(
//             Icons.share,
//             color: Colors.white,
//             size: 25,
//           ),
//           backgroundColor: Colors.orange,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//       ]),
//     );
//   }
//
//   /// This method captures the screenshot and shares the file
//   _takeScreenshotandShare1() async {
//     try {
//       // Capture the screenshot
//       Uint8List? image = await _controller.capture(
//           delay: Duration(milliseconds: 10), pixelRatio: 2.0);
//
//       if (image != null) {
//         String? directory;
//         // Get the external storage directory (publicly accessible)
//         if (Platform.isAndroid) {
//           directory = (await getApplicationDocumentsDirectory())?.path;
//         } else if (Platform.isIOS) {
//           directory = (await getApplicationDocumentsDirectory()).path;
//         }
//
//         if (directory != null) {
//           // Create a file path
//           String filePath = '$directory/screenshot.png';
//
//           // Write the image data to a file
//           File imgFile = File(filePath);
//           await imgFile.writeAsBytes(image);
//
//           print("File Saved to $filePath");
//
//           // Create an XFile from the file path
//           XFile xFile = XFile(filePath);
//
//           // Share the file using shareXFiles
//           await Share.shareXFiles([xFile], text: "Gift Voucher");
//         } else {
//           print("Error: External storage directory not found");
//         }
//       } else {
//         print("Image capture failed");
//       }
//     } catch (e) {
//       print("onError: $e");
//     }
//   }
// }
//
// Future<dynamic> ShowCapturedWidget(
//     BuildContext context, Uint8List capturedImage) {
//   return showDialog(
//     useSafeArea: false,
//     context: context,
//     builder: (context) => Scaffold(
//       appBar: AppBar(
//         title: Text("Gift Voucher"),
//         backgroundColor: Colors.orange, // Your primary color
//       ),
//       body: SafeArea(
//         child: Center(
//             child: capturedImage != null
//                 ? Image.memory(capturedImage)
//                 : Container()),
//       ),
//     ),
//   );
// }
