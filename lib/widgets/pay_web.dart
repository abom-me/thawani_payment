//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:thawani_payment/helper/alerts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
//
// import '../helper/req_helper.dart';
//
// class PayWebWidget extends StatefulWidget {
//   const PayWebWidget(
//       {super.key,
//         required this.uri,
//         required this.paid,
//         required this.unpaid,
//         required this.url,
//         required this.api,
//         required this.testMode});
//   final String uri;
//   final String url;
//   final String api;
//   final Function paid;
//   final bool testMode;
//   final Function unpaid;
//
//   @override
//   State<PayWebWidget> createState() => _PayWebWidgetState();
// }
//
// class _PayWebWidgetState extends State<PayWebWidget> with WidgetsBindingObserver{
//   bool open = true;
//   bool paid = false;
//   bool dataSent = false;
//   bool isCheck=true;
//   late Map<String, dynamic> dataBack;
//   final GlobalKey webViewKey = GlobalKey();
//   late AppLifecycleState _notification;
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch(state){
//       case AppLifecycleState.resumed:
//         check();
//         break;
//       case AppLifecycleState.inactive:
//         print("app in inactive");
//         break;
//       case AppLifecycleState.paused:
//         print("app in paused");
//         break;
//       case AppLifecycleState.detached:
//         print("app in detached");
//         break;
//     }
//   }
//
//   @override
//   initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     inti();
//   }
//   check() async {
// Alert.loading(context, "Checking Payment Status");
//
//     var dataBack = await RequestHelper.getRequest(
//         widget.uri, widget.api, widget.testMode);
//     Navigator.pop(context);
//     if (dataBack['data']['payment_status'] == "paid" ) {
//       if (context.mounted) Navigator.pop(context);
//       widget.paid(dataBack);
//     } else if (dataBack['data']['payment_status'] ==
//         "cancelled" ) {
//       if (context.mounted) Navigator.pop(context);
//       widget.unpaid(dataBack);
//     }else{
//      await Alert.msg(context, "Not paid", "We will redirect you to the payment page again",);
//       inti();
//     }
//
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
// inti() async {
//   await launchUrl(
//     Uri.parse(widget.url),
// );
//   print("Hello");
// }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Text("Close The Window after you pay"),
//
//
//
//
//         // WebViewWidget(
//         //   controller: WebViewController()
//         //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         //     ..setBackgroundColor(const Color(0xffffffff))
//         //     ..setNavigationDelegate(
//         //       NavigationDelegate(
//         //         onProgress: (int progress) {},
//         //         onPageStarted: (String url) {},
//         //         onPageFinished: (String url) {},
//         //         onWebResourceError: (WebResourceError error) {},
//         //         onNavigationRequest: (NavigationRequest request) async {
//         //           var dataBack = await RequestHelper.getRequest(
//         //               widget.uri, widget.api, widget.testMode);
//         //
//         //           if (dataBack['data']['payment_status'] == "paid" &&
//         //               request.url == dataBack['data']['success_url']) {
//         //             if (context.mounted) Navigator.pop(context);
//         //             widget.paid(dataBack);
//         //           } else if (dataBack['data']['payment_status'] ==
//         //               "cancelled" &&
//         //               request.url == dataBack['data']['cancel_url']) {
//         //             if (context.mounted) Navigator.pop(context);
//         //             widget.unpaid(dataBack);
//         //           }
//         //
//         //           return NavigationDecision.navigate;
//         //         },
//         //       ),
//         //     )
//         //     ..loadRequest(Uri.parse(widget.url)),
//         // ),
//       ),
//     );
//   }
// }
