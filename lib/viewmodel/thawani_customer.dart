import 'package:shared_preferences/shared_preferences.dart';
import 'package:thawani_payment/helper/req_helper_new.dart';
import 'package:thawani_payment/models/create_customers.dart';
import 'package:thawani_payment/thawani_payment.dart';

class ThawaniCustomers {
  checker({
    required bool testMode,
    required String apiKey,
    String? customer,
    required String customerId,
    required void Function(Map<String, dynamic>) onError,
    required void Function(String customerID, String customerRefrensID) onDone,
    required void Function(CreateCustomerModel data) newCustomer,
  }) async {
    if (customer != null) await ThawaniCustomer.add(customerID: customer);
    SharedPreferences share = await SharedPreferences.getInstance();
    String? savedCustomerId = share.getString('customerId');
    if (savedCustomerId != null) {
      onDone(savedCustomerId, customerId);
    } else {
      create(
          testMode: testMode,
          apiKey: apiKey,
          customerId: customerId,
          onError: onError,
          onDone: (data) {
            newCustomer(data);
            onDone(data.data!.id!, data.data!.customerClientId!);
          });
    }
  }

  create({
    required bool testMode,
    required String apiKey,
    required String customerId,
    required void Function(Map<String, dynamic>) onError,
    required void Function(CreateCustomerModel data) onDone,
  }) async {
    final String url = testMode
        ? 'https://uatcheckout.thawani.om/api/v1/customers'
        : 'https://checkout.thawani.om/api/v1/customers';
    await Request.post(url: url, data: {
      'client_customer_id': customerId
    }, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      // print(value);
      if (value['status'] == 200) {
        onDone(CreateCustomerModel.fromJson(value['data']));
      } else {
        onError(value);
      }
    });
  }

  // getId(String clintID, String apiKey, bool testMode,
  //     {required void Function(bool haveID, String? id) onDone}) async {
  //   final String url = testMode
  //       ? 'https://uatcheckout.thawani.om/api/v1/customers'
  //       : 'https://checkout.thawani.om/api/v1/customers';
  //   await Request.get(url: '$url?skip=1&limit=100000000', headers: {
  //     'Content-Type': "application/json",
  //     'thawani-api-key': apiKey
  //   }).then((value) {
  //     if (value['code'] == 2000) {
  //       CustomersModel data = CustomersModel.fromJson(value);
  //       for (var element in data.data!) {
  //         if (element.customerClientId == clintID) {
  //           onDone(true, element.id);
  //         } else {
  //           onDone(false, null);
  //         }
  //       }
  //     } else {}
  //   });
  // }
}
