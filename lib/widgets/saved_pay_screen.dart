import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../viewmodel/thawani_paymentIntent.dart';

class PaySavedWidget extends StatefulWidget {
  const PaySavedWidget(
      {Key? key,
      required this.paid,
      required this.unpaid,
      required this.url,
      required this.api,
      required this.testMode,
      required this.returnLink,
      required this.payID})
      : super(key: key);

  final String url;
  final String returnLink;
  final String api;
  final String payID;
  final void Function(Map<String, dynamic> data) paid;
  final bool testMode;
  final void Function(Map<String, dynamic> data) unpaid;

  @override
  State<PaySavedWidget> createState() => _PaySavedWidgetState();
}

class _PaySavedWidgetState extends State<PaySavedWidget> {
  bool open = true;
  bool paid = false;
  bool dataSent = false;
  bool showLoading = false;
  late Map<String, dynamic> dataBack;
  PaymentIntentViewModel pay = PaymentIntentViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0xffffffff))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {},
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {},
                    onNavigationRequest: (NavigationRequest request) async {
                      if (request.url == widget.returnLink) {
                        setState(() {
                          showLoading = true;
                        });
                        pay.check(
                            id: widget.payID,
                            apiKey: widget.api,
                            testMode: widget.testMode,
                            onDone: (data) {
                              if (data.data!.status == "succeeded") {
                                Navigator.pop(context);
                                widget.paid(data.data!.toJson());
                              } else {
                                Navigator.pop(context);
                                widget.unpaid(data.data!.toJson());
                              }
                            },
                            onError: (d) {});
                      }

                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(widget.url)),
            ),
            if (showLoading)
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}
