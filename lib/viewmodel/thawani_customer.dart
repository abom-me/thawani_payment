import 'package:shared_preferences/shared_preferences.dart';
import 'package:thawani_payment/helper/req_helper_new.dart';
import 'package:thawani_payment/models/create_customers.dart';
import 'package:thawani_payment/thawani_payment.dart';

/// ViewModel for handling customer operations with Thawani payment API.
class ThawaniCustomers {
  /// Checks if a customer exists and creates one if it doesn't.
  ///
  /// [testMode] - Flag indicating if the test mode is enabled.
  /// [apiKey] - The API key for authentication.
  /// [customer] - Optional customer ID to be checked.
  /// [customerId] - The customer's reference ID.
  /// [onError] - Callback function to be executed on an error.
  /// [onDone] - Callback function to be executed when a customer is found or created.
  /// [newCustomer] - Callback function to be executed when a new customer is created.
  Future<void> checker({
    required bool testMode,
    required String apiKey,
    String? customer,
    required String customerId,
    required void Function(Map<String, dynamic>) onError,
    required void Function(String customerID, String customerRefrensID) onDone,
    required void Function(CreateCustomerModel data) newCustomer,
  }) async {
    // Add a customer to Thawani if the customer ID is provided.
    if (customer != null) await ThawaniCustomer.add(customerID: customer);

    // Retrieve stored customer ID from shared preferences.
    SharedPreferences share = await SharedPreferences.getInstance();
    String? savedCustomerId = share.getString('customerId');

    // If a customer ID is found in shared preferences, call the onDone callback.
    if (savedCustomerId != null) {
      onDone(savedCustomerId, customerId);
    } else {
      // If no customer ID is found, create a new customer.
      create(
          testMode: testMode,
          apiKey: apiKey,
          customerId: customerId,
          onError: onError,
          onDone: (data) {
            // Call the newCustomer callback when a new customer is created.
            newCustomer(data);
            onDone(data.data!.id!, data.data!.customerClientId!);
          });
    }
  }

  /// Creates a new customer.
  ///
  /// [testMode] - Flag indicating if the test mode is enabled.
  /// [apiKey] - The API key for authentication.
  /// [customerId] - The customer's reference ID.
  /// [onError] - Callback function to be executed on an error.
  /// [onDone] - Callback function to be executed on successful customer creation.
  Future<void> create({
    required bool testMode,
    required String apiKey,
    required String customerId,
    required void Function(Map<String, dynamic>) onError,
    required void Function(CreateCustomerModel data) onDone,
  }) async {
    // Define the URL based on the test mode.
    final String url = testMode
        ? 'https://uatcheckout.thawani.om/api/v1/customers'
        : 'https://checkout.thawani.om/api/v1/customers';

    // Send a POST request to create a new customer.
    await Request.post(url: url, data: {
      'client_customer_id': customerId
    }, headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['status'] == 200) {
        // Parse the response data into a CreateCustomerModel and call the onDone callback.
        onDone(CreateCustomerModel.fromJson(value['data']));
      } else {
        // Handle errors by calling the onError callback.
        onError(value);
      }
    });
  }

// Method for getting a customer ID has been commented out.
// Uncomment and implement if needed.
/*
  Future<void> getId(
    String clintID,
    String apiKey,
    bool testMode,
    {required void Function(bool haveID, String? id) onDone}
  ) async {
    final String url = testMode
        ? 'https://uatcheckout.thawani.om/api/v1/customers'
        : 'https://checkout.thawani.om/api/v1/customers';

    await Request.get(url: '$url?skip=1&limit=100000000', headers: {
      'Content-Type': "application/json",
      'thawani-api-key': apiKey
    }).then((value) {
      if (value['code'] == 2000) {
        CustomersModel data = CustomersModel.fromJson(value);
        for (var element in data.data!) {
          if (element.customerClientId == clintID) {
            onDone(true, element.id);
          } else {
            onDone(false, null);
          }
        }
      } else {
        // Handle errors if necessary
      }
    });
  }
  */
}
