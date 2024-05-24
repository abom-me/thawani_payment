
import 'package:flutter/material.dart';
import 'package:thawani_payment/helper/sizes.dart';

class Alert {
  static msg(context, title, msg) {
    return showDialog(
      context: context,
      builder: (ctx) => Stack(
        children: [
          AlertDialog(
            scrollable: true,
            elevation: 0,

            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            content: Container(
              alignment: Alignment.center,

              width: Sizes.width(context),

              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 17,
                                fontWeight: FontWeight.w900),
                          ),
                     const SizedBox(height: 10),
                          Text(
                            msg,
                            style: const TextStyle(
                                // color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  Container(
                    width: Sizes.width(context),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        "ok",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static loading(context, title, {bool? ableToClose = false}) {
    showDialog(
      context: context,
      barrierDismissible: ableToClose ?? false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          // backgroundColor: Colors.white,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // LoadingAnimationWidget.beat(color: purpleColor, size: 20),
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
