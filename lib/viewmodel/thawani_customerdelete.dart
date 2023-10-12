import 'package:shared_preferences/shared_preferences.dart';

class ThawaniCustomer {
  static Future<bool> delete() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    await share.remove('customerId');
    return true;
  }

  static Future<String> get() async {
    SharedPreferences share = await SharedPreferences.getInstance();

    return share.getString('customerId') ?? "There is no saved customer";
  }

  static add(
      {required String customerID, void Function(dynamic data)? onAdd}) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    await share
        .setString('customerId', customerID)
        .then((value) => onAdd?.call(value));
  }
}
