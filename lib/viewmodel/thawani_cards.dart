import 'package:flutter/material.dart';
import 'package:thawani_payment/helper/req_helper_new.dart';
import 'package:thawani_payment/viewmodel/keys_viewmodel.dart';

import 'package:thawani_payment/models/create.dart';
import 'package:thawani_payment/models/saveed_cards_model.dart';
import 'package:thawani_payment/widgets/pay.dart';

class ThawaniCards {
  final KeysViewModel keysViewModel = KeysViewModel();

  /// Retrieves saved cards associated with a customer ID.
  ///
  /// [testMode] - Flag indicating if the test mode is enabled.
  /// [customerId] - The customer ID for whom the saved cards are retrieved.
  /// [apiKey] - The API key for authentication.
  /// [onError] - Callback function to be executed on an error.
  /// [onDone] - Callback function to be executed on successful retrieval.
  Future<void> get({
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
      if (value['code'] == 2000 || value['code'] == 4003) {
        // Parse the response data into a SavedCardsModel and call onDone callback.
        onDone(SavedCardsModel.fromJson(value));
      } else {
        // Handle errors by calling the onError callback.
        onError(value);
      }
    });
  }

  /// Deletes a saved card.
  ///
  /// [cardId] - The ID of the card to be deleted.
  /// [onDelete] - Callback function to be executed on successful deletion.
  /// [onError] - Callback function to be executed on an error.
  void delete({
    required String cardId,
    required void Function() onDelete,
    required void Function() onError,
  }) {
    String url = keysViewModel.isTestMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_methods/$cardId"
        : "https://checkout.thawani.om/api/v1/payment_methods/$cardId";

    Request.delete(url: url, data: {}, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': keysViewModel.userApiKey
    }).then((value) {
      if (value['data']['code'] == 2003) {
        // Call onDelete callback on successful deletion.
        onDelete();
      } else {
        print(value);
        // Handle errors if necessary.
      }
    });
  }

  /// Adds a payment session.
  ///
  /// [context] - The BuildContext for navigation.
  /// [onCreate] - Callback function to be executed on successful session creation.
  /// [onCancelled] - Callback function to be executed if payment is cancelled.
  /// [onPaid] - Callback function to be executed on successful payment.
  /// [onError] - Callback function to be executed on an error.
  void add(
    BuildContext context, {
    required void Function(Create create) onCreate,
    required void Function(Map<String, dynamic> payStatus) onCancelled,
    required void Function(Map<String, dynamic> payStatus) onPaid,
    required void Function(Map error)? onError,
  }) {
    String url = keysViewModel.isTestMode
        ? "https://uatcheckout.thawani.om/api/v1/checkout/session"
        : "https://checkout.thawani.om/api/v1/checkout/session";
    Request.post(url: url, data: {
      "customer_id": keysViewModel.userCustomerID,
      "save_card_on_success": true,
      "client_reference_id": keysViewModel.userClintID,
      "mode": "payment",
<<<<<<< Updated upstream
      "products": keysViewModel.userProducts.map((e) => e.toJson()).toList(),
      "success_url": keysViewModel.userSuccessUrl ??
          'https://abom.me/package/thawani/suc.php',
      "cancel_url": keysViewModel.userCancelUrl ??
          "https://abom.me/package/thawani/can.php",
      "metadata": keysViewModel.userMetadata,
=======
      "products": userProducts.map((e) => e.toJson()).toList(),
      "success_url":
          userSuccessUrl ?? 'https://example.com/package/thawani/suc.php',
      "cancel_url": userCancelUrl ?? "https://example.com/package/thawani/can.php",
      "metadata": userMetadata,
>>>>>>> Stashed changes
    }, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': keysViewModel.userApiKey
    }).then((value) {
      if (value['data']['code'] == 2004) {
        // Call onCreate callback on successful session creation and navigate to PayWidget.
        onCreate(Create.fromJson(value['data']));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWidget(
              api: keysViewModel.userApiKey,
              uri: value['data']['data']['session_id'],
              url: keysViewModel.isTestMode == true
                  ? 'https://uatcheckout.thawani.om/pay/${value['data']['data']['session_id']}?key=${keysViewModel.userPKey}'
                  : 'https://checkout.thawani.om/pay/${value['data']['data']['session_id']}?key=${keysViewModel.userPKey}',
              paid: (statusClass) {
                onPaid(statusClass);
              },
              unpaid: (statusClass) {
                onCancelled(statusClass);
              },
              testMode: keysViewModel.isTestMode,
            ),
          ),
        );
      } else if (value['data']['code'] != 2004) {
        // Call onError callback for other error cases.
        onError!(value);
      } else if (value['data']['code'] == null) {
        // Call onError callback if no error code is provided.
        onError!(value['data']);
      }
    });
  }
}
