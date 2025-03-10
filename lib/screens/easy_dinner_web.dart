// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../utils/datasource.dart';
//
// //import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WebViewEasydinner extends StatefulWidget {
//   const WebViewEasydinner({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewEasydinner> createState() => _WebViewEasydinnerState();
// }
//
// class _WebViewEasydinnerState extends State<WebViewEasydinner> {
//   double _progress = 0;
//   late InAppWebViewController inAppWebViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         var isLastPage = await inAppWebViewController.canGoBack();
//         if (isLastPage) {
//           inAppWebViewController.goBack();
//           return false;
//         }
//
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,)),
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           title: const Text('FCH Eazy Diner',style: TextStyle(
//             color: Colors.white,fontWeight: FontWeight.w600
//           ),),
//           backgroundColor: primaryColor,
//           centerTitle: true,
//
//         ),
//         body: Stack(
//           children: [
//             InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: Uri.parse("https://www.eazydiner.com/?_branch_referrer=H4sIAAAAAAAAA8soKSkottLXN8w1y9VLLCjQy8nMy9YPyUjzdsupCDF1TrKPj08qSsxLzohPy8kvj89MsTU0NjU3NrC0NLawMDM3MDI1NTcFAJydeU9GAAAA&link_click_id=1357309537442145537"
//                    // "https://1m6m.app.link/j7j8oLQD6Cb/"
//                     ),
//               ),
//               initialUserScripts: UnmodifiableListView([
//                 UserScript(
//                   source: """
//       window.addEventListener('DOMContentLoaded', function(event) {
//         var header = document.querySelector('.elementor-location-header');
//         if (header != null) {
//           header.remove();
//         }
//         var footer = document.querySelector('.elementor-location-footer');
//         if (footer != null) {
//           footer.remove();
//         }
//       });
//       """,
//                   injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
//                 )
//               ]),
//               onWebViewCreated: (InAppWebViewController controller) {
//                 inAppWebViewController = controller;
//                 controller.setOptions(options: InAppWebViewGroupOptions(
//                   crossPlatform: InAppWebViewOptions(
//                     useOnDownloadStart: true,
//                     javaScriptEnabled: true,
//                     mediaPlaybackRequiresUserGesture: false,
//                   ),
//                 ));
//               },
//               onProgressChanged: (InAppWebViewController controller, int progress) {
//                 setState(() {
//                   _progress = progress / 100;
//                 });
//               },
//               onLoadError: (controller, url, code, message) {
//                 print("Error $code: $message, URL: $url");
//               },
//               onLoadHttpError: (controller, url, statusCode, description) {
//                 print("HTTP error $statusCode: $description, URL: $url");
//               },
//               onLoadStart: (controller, url) {
//                 print("Loading URL: $url");
//               },
//               onLoadStop: (controller, url) {
//                 print("Finished loading URL: $url");
//               },
//               shouldOverrideUrlLoading: (controller, navigationAction) async {
//                 var uri = navigationAction.request.url;
//
//                 if (uri != null && uri.scheme != "http" && uri.scheme != "https") {
//                   // If the URL scheme is not http or https, handle it differently
//                   if (await canLaunch(uri.toString())) {
//                     // If there's an app installed that can handle the URL, launch it
//                     await launch(uri.toString());
//                   } else {
//                     // If no app can handle the URL, show an error message or handle it in some way
//                     print("Cannot handle URL: $uri");
//                   }
//                   return NavigationActionPolicy.CANCEL;
//                 }
//                 return NavigationActionPolicy.ALLOW;
//               },
//             ),
//
//             _progress < 1
//                 ? Container(
//               child: LinearProgressIndicator(
//                 value: _progress,
//               ),
//             )
//                 : SizedBox(),
//
//             // InAppWebView(
//             //   initialUrlRequest: URLRequest(
//             //       url: Uri.parse("https://1m6m.app.link/j7j8oLQD6Cb/")),
//             //   initialUserScripts: UnmodifiableListView([
//             //     UserScript(source: """
//             //   window.addEventListener('DOMContentLoaded', function(event) {
//             //     var header = document.querySelector('.elementor-location-header'); // use here the correct CSS selector for your use case
//             //     if (header != null) {
//             //       header.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use header.style.display = 'none';
//             //     }
//             //     var footer = document.querySelector('.elementor-location-footer'); // use here the correct CSS selector for your use case
//             //     if (footer != null) {
//             //       footer.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use footer.style.display = 'none';
//             //     }
//             //   });
//             //   """, injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
//             //   ]),
//             //   onWebViewCreated: (InAppWebViewController controller) {
//             //     inAppWebViewController = controller;
//             //   },
//             //   onProgressChanged:
//             //       (InAppWebViewController controller, int progress) {
//             //     setState(() {
//             //       _progress = progress / 100;
//             //     });
//             //   },
//             // ),
//             // _progress < 1
//             //     ? Container(
//             //         child: LinearProgressIndicator(
//             //           value: _progress,
//             //         ),
//             //       )
//             //     : SizedBox()
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewEasydinner extends StatelessWidget {
  const WebViewEasydinner({Key? key}) : super(key: key);

  Future<void> _launchURL(BuildContext context) async {
    const url = "https://1m6m.app.link/j7j8oLQD6Cbd/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot open the link: $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'FCH Eazy Diner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange.shade900,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _launchURL(context),
          child: Text('Open FCH Eazy Diner'),
        ),
      ),
    );
  }
}
