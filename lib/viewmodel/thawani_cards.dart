import 'package:flutter/material.dart';
import 'package:thawani_payment/helper/req_helper_new.dart';
import 'package:thawani_payment/viewmodel/keys_viewmodel.dart';

import 'package:thawani_payment/models/create.dart';
import 'package:thawani_payment/models/saveed_cards_model.dart';
import 'package:thawani_payment/widgets/pay.dart';

class ThawaniCards {
  get({
    required bool testMode,
    required String customerId,
    required String apiKey,
    required void Function(Map<String, dynamic>) onError,
    required void Function(SavedCardsModel data) onDone,
  }) async {
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_methods"
        : "https://checkout.thawani.om/api/v1/payment_methods";

    await Request.get(url: "$url?customer_id=$customerId", headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['code'] == 2000) {
        onDone(SavedCardsModel.fromJson(value));
      } else {
        onError(value);
      }
    });
  }

  delete(
      {required String cardId,
      required void Function() onDelete,
      required void Function() onError}) {
    String url = isTestMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_methods/$cardId"
        : "https://checkout.thawani.om/api/v1/payment_methods/$cardId";

    Request.delete(url: url, data: {}, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': userApiKey
    }).then((value) => {
          if (value['data']['code'] == 2003) {onDelete()} else {}
        });
  }

  add(
    BuildContext context, {
    required void Function(Create create) onCreate,

    ///The Function And The Result Of Data If The User  Cancelled The Payment.
    required void Function(Map<String, dynamic> payStatus) onCancelled,

    ///The Function And The Result Of Data If The User  Cancelled The Payment.
    required void Function(Map<String, dynamic> payStatus) onPaid,

    ///The Function And The Reason Of The Error,  If Any Error Happen.
    required void Function(Map error)? onError,
  }) {
    String url = isTestMode
        ? "https://uatcheckout.thawani.om/api/v1/checkout/session"
        : "https://checkout.thawani.om/api/v1/checkout/session";
    Request.post(url: url, data: {
      "customer_id": userCustomerID,
      "save_card_on_success": true,
      "client_reference_id": userClintID,
      "mode": "payment",
      "products": userProducts,
      "success_url":
          userSuccessUrl ?? 'https://abom.me/package/thawani/suc.php',
      "cancel_url": userCancelUrl ?? "https://abom.me/package/thawani/can.php",
      if (userMetadata != null) "metadata": userMetadata,
    }, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': userApiKey
    }).then((value) => {
          if (value['data']['code'] == 2004)
            {
              onCreate(Create.fromJson(value['data'])),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PayWidget(
                            api: userApiKey,
                            uri: value['data']['data']['session_id'],
                            url: isTestMode == true
                                ? 'https://uatcheckout.thawani.om/pay/${value['data']['data']['session_id']}?key=$userPKey'
                                : 'https://checkout.thawani.om/pay/${value['data']['data']['session_id']}?key=$userPKey',
                            paid: (statusClass) {
                              onPaid(statusClass);
                            },
                            unpaid: (statusClass) {
                              onCancelled(statusClass);
                            },
                            testMode: isTestMode,
                          ))),
            }
          else if (value['data']['code'] != 2004)
            {onError!(value)}
          else if (value['data']['code'] == null)
            {onError!(value['data'])}
        });
  }
}
