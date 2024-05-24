import 'package:flutter/material.dart';
import 'package:thawani_payment/viewmodel/keys_viewmodel.dart';

import '../helper/req_helper.dart';
import '../models/create.dart';
import '../models/products.dart';
import '../widgets/pay.dart';

class ThawaniPay {
  KeysViewModel keysViewModel = KeysViewModel();

  /// Initiates the payment process via Thawani API.
  ///
  /// [context] - The BuildContext for navigation.
  /// [api] - The Thawani API endpoint.
  /// [publishKey] - The publish key for authentication.
  /// [clintID] - The client reference ID.
  /// [customerID] - The customer ID.
  /// [products] - List of products to be purchased.
  /// [successUrl] - URL to redirect on successful payment.
  /// [cancelUrl] - URL to redirect on cancelled payment.
  /// [metadata] - Metadata associated with the payment.
  /// [testMode] - Flag indicating if test mode is enabled.
  /// [onCreate] - Callback function to be executed on successful creation of payment session.
  /// [onCancelled] - Callback function to be executed if payment is cancelled.
  /// [onPaid] - Callback function to be executed on successful payment.
  /// [onError] - Callback function to be executed on error.
  Future<void> payApi({
    required BuildContext context,
    required String api,
    required String publishKey,
    required String clintID,
    required String customerID,
    required List<Product> products,
    String? successUrl,
    String? cancelUrl,
    required Map<String, dynamic> metadata,
    required bool testMode,
    required void Function(Create create) onCreate,
    required void Function(Map<String, dynamic> payStatus) onCancelled,
    required void Function(Map<String, dynamic> payStatus) onPaid,
    required Function(Map error)? onError,
  }) async {
    late Map<String, dynamic> dataBack;

    Future<Create> createS() async {
      return Create.fromJson(dataBack);
    }

    dataBack = await RequestHelper.postRequest(
        api,
        {
          if (keysViewModel.userSaveCard) "customer_id": customerID,
          "save_card_on_success": keysViewModel.userSaveCard,
          if (keysViewModel.expiredInMinuets != null) "expired_in_minutes": keysViewModel.expiredInMinuets,
          "client_reference_id": clintID,
          "mode": "payment",
          "products": products.map((e) => e.toJson()).toList(),
          "success_url": successUrl ?? 'https://abom.me/package/thawani/suc.php',
          "cancel_url": cancelUrl ?? "https://abom.me/package/thawani/can.php",
          "metadata": metadata,
        },
        testMode);
    if (dataBack['code'] == 2004) {
      createS().then((value) {
        onCreate(value);
      });
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWidget(
              api: api,
              uri: dataBack['data']['session_id'],
              url: testMode == true
                  ? 'https://uatcheckout.thawani.om/pay/${dataBack['data']['session_id']}?key=$publishKey'
                  : 'https://checkout.thawani.om/pay/${dataBack['data']['session_id']}?key=$publishKey',
              paid: (statusClass) {
                onPaid(statusClass);
              },
              unpaid: (statusClass) {
                onCancelled(statusClass);
              },
              testMode: testMode,
            ),
          ),
        );
      }
      if (context.mounted) return;
    } else if (dataBack['code'] != 2004) {
      return onError!(dataBack);
    } else if (dataBack['code'] == null) {
      return onError!(dataBack);
    }
  }
}
