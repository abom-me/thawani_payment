import '../helper/req_helper_new.dart';
import '../models/check_payment.dart';
import '../models/conform_payment.dart';
import '../models/create_payment.dart';

/// ViewModel for handling payment intents using the Thawani payment API.
class PaymentIntentViewModel {
  /// Creates a payment intent.
  ///
  /// [apiKey] - The API key for authentication.
  /// [amount] - The amount to be charged.
  /// [returnLink] - The URL to redirect to after the payment process.
  /// [testMode] - Flag indicating if the test mode is enabled.
  /// [cardID] - The ID of the card to be charged.
  /// [clientID] - The client's reference ID.
  /// [metadata] - Additional metadata for the payment.
  /// [onDone] - Callback function to be executed on successful payment creation.
  /// [onError] - Callback function to be executed on an error.
  void create(
      String apiKey, {
        required int amount,
        required String returnLink,
        required bool testMode,
        required String cardID,
        required String clientID,
        Map<String, dynamic>? metadata,
        required void Function(ConformPaymentModel data, CreatePaymentModel pData)
        onDone,
        required void Function(Map<String, dynamic> data) onError}) {
    // Define the URL based on the test mode.
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_intents"
        : 'https://checkout.thawani.om/api/v1/payment_intents';

    // Send a POST request to create a payment intent.
    Request.post(url: url, data: {
      "payment_method_id": cardID,
      "amount": amount,
      "client_reference_id": clientID,
      "return_url": returnLink,
      if (metadata != null) "metadata": metadata
    }, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['status'] == 200) {
        // Parse the response data into a CreatePaymentModel.
        CreatePaymentModel model = CreatePaymentModel.fromJson(value['data']);

        // Confirm the payment intent.
        conform(
            id: model.data!.id!,
            apiKey: apiKey,
            testMode: testMode,
            onDone: (data) {
              onDone(data, model);
            },
            onError: (error) {
              onError(error);
            });
      } else {
        // Handle errors by calling the onError callback.
        onError(value['data']);
      }
    });
  }

  /// Confirms a payment intent.
  ///
  /// [id] - The ID of the payment intent to confirm.
  /// [apiKey] - The API key for authentication.
  /// [testMode] - Flag indicating if the test mode is enabled.
  /// [onDone] - Callback function to be executed on successful confirmation.
  /// [onError] - Callback function to be executed on an error.
  void conform({
    required String id,
    required String apiKey,
    required bool testMode,
    required void Function(ConformPaymentModel data) onDone,
    required void Function(Map<String, dynamic> data) onError}) {
    // Define the URL based on the test mode.
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_intents/$id/confirm"
        : 'https://checkout.thawani.om/api/v1/payment_intents/$id/confirm';

    // Send a POST request to confirm the payment intent.
    Request.post(url: url, data: {}, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['status'] == 200) {
        // Parse the response data into a ConformPaymentModel.
        ConformPaymentModel model = ConformPaymentModel.fromJson(value['data']);
        onDone(model);
      } else {
        // Handle errors by calling the onError callback.
        onError(value['data']);
      }
    });
  }

  /// Checks the status of a payment intent.
  ///
  /// [id] - The ID of the payment intent to check.
  /// [apiKey] - The API key for authentication.
  /// [testMode] - Flag indicating if the test mode is enabled.
  /// [onDone] - Callback function to be executed on successful status check.
  /// [onError] - Callback function to be executed on an error.
  void check({
    required String id,
    required String apiKey,
    required bool testMode,
    required void Function(CheckPaymentModel data) onDone,
    required void Function(Map<String, dynamic> data) onError}) {
    // Define the URL based on the test mode.
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_intents/$id"
        : "https://checkout.thawani.om/api/v1/payment_intents/$id";

    // Send a GET request to check the status of the payment intent.
    Request.get(url: url, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['code'] == 2000) {
        // Parse the response data into a CheckPaymentModel.
        onDone(CheckPaymentModel.fromJson(value));
      } else {
        // Handle errors by calling the onError callback.
        onError(value);
      }
    });
  }
}
