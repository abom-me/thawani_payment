import '../helper/req_helper_new.dart';
import '../models/check_payment.dart';
import '../models/conform_payment.dart';
import '../models/create_payment.dart';

class PaymentIntentViewModel {
  create(apiKey,
      {required int amount,
      required String returnLink,
      required bool testMode,
      required String cardID,
      required String clientID,
      Map<String, dynamic>? metadata,
      required void Function(ConformPaymentModel data, CreatePaymentModel pData)
          onDone,
      required void Function(Map<String, dynamic> data) onError}) {
    // https://uatcheckout.thawani.om/api/v1/payment_intents
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_intents"
        : 'https://checkout.thawani.om/api/v1/payment_intents';
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
        CreatePaymentModel model = CreatePaymentModel.fromJson(value['data']);
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
        onError(value['data']);
      }
    });
  }

  conform(
      {required String id,
      required String apiKey,
      required bool testMode,
      required void Function(ConformPaymentModel data) onDone,
      required void Function(Map<String, dynamic> data) onError}) {
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_intents/$id/confirm"
        : 'https://checkout.thawani.om/api/v1/payment_intents/$id/confirm';
    Request.post(url: url, data: {}, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['status'] == 200) {
        ConformPaymentModel model = ConformPaymentModel.fromJson(value['data']);
        onDone(model);
      } else {
        onError(value['data']);
      }
    });
  }

  check(
      {required String id,
      required String apiKey,
      required bool testMode,
      required void Function(CheckPaymentModel data) onDone,
      required void Function(Map<String, dynamic> data) onError}) {
    String url = testMode
        ? "https://uatcheckout.thawani.om/api/v1/payment_intents/$id"
        : "https://checkout.thawani.om/api/v1/payment_intents/$id";

    Request.get(url: url, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) => {
          if (value['code'] == 2000)
            {onDone(CheckPaymentModel.fromJson(value))}
          else
            {onError(value)}
        });
  }
}
