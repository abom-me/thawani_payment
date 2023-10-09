import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../helper/req_helper.dart';

class PayWidget extends StatefulWidget {
  const PayWidget(
      {Key? key,
      required this.uri,
      required this.paid,
      required this.unpaid,
      required this.url,
      required this.api,
      required this.testMode})
      : super(key: key);
  final String uri;
  final String url;
  final String api;
  final Function paid;
  final bool testMode;
  final Function unpaid;

  @override
  State<PayWidget> createState() => _PayWidgetState();
}

class _PayWidgetState extends State<PayWidget> {
  bool open = true;
  bool paid = false;
  bool dataSent = false;
  late Map<String, dynamic> dataBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
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
                  var dataBack = await RequestHelper.getRequest(
                      widget.uri, widget.api, widget.testMode);

                  if (dataBack['data']['payment_status'] == "paid" &&
                      request.url == dataBack['data']['success_url']) {
                    if (context.mounted) Navigator.pop(context);
                    widget.paid(dataBack);
                  } else if (dataBack['data']['payment_status'] ==
                          "cancelled" &&
                      request.url == dataBack['data']['cancel_url']) {
                    if (context.mounted) Navigator.pop(context);
                    widget.unpaid(dataBack);
                  }

                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(widget.url)),
        ),
      ),
    );
  }
}
