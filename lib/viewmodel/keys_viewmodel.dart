import 'package:flutter/material.dart';
import 'package:thawani_payment/models/products.dart';

/// ViewModel for managing user keys and payment-related settings.
/// Utilizes the Singleton pattern to ensure a single instance.
class KeysViewModel extends ChangeNotifier {
  // Singleton instance
  static final KeysViewModel _instance = KeysViewModel._internal();

  /// Factory constructor to return the singleton instance.
  factory KeysViewModel() {
    return _instance;
  }

  /// Private internal constructor for singleton pattern.
  KeysViewModel._internal();

  // Private fields for user-related properties.
  late String _userApiKey;
  int? expiredInMinuets;
  String? _userDeleteLoading;
  String? _userDeleteError;
  Widget? _userSavedCardsAppBar;
  late String _userPKey;
  late bool _userSaveCard;
  late String? _userSuccessUrl;
  late String? _userCancelUrl;
  late String _userClintID;
  late String _userCustomerID;
  late String _userSelectCardLoading;
  bool _isTestMode = false;
  late List<Product> _userProducts;
  late Map<String, dynamic> _userMetadata;
  Color? _userSavedCardBackground;
  Color? _userSavedCardTextColor = Colors.white;

  // Getters for accessing private fields.
  String get userApiKey => _userApiKey;
  String? get userDeleteLoading => _userDeleteLoading;
  String? get userDeleteError => _userDeleteError;
  Widget? get userSavedCardsAppBar => _userSavedCardsAppBar;
  String get userPKey => _userPKey;
  bool get userSaveCard => _userSaveCard;
  String? get userSuccessUrl => _userSuccessUrl;
  String? get userCancelUrl => _userCancelUrl;
  String get userClintID => _userClintID;
  String get userCustomerID => _userCustomerID;
  String get userSelectCardLoading => _userSelectCardLoading;
  bool get isTestMode => _isTestMode;
  List<Product> get userProducts => _userProducts;
  Map<String, dynamic> get userMetadata => _userMetadata;
  Color? get userSavedCardBackground => _userSavedCardBackground;
  Color? get userSavedCardTextColor => _userSavedCardTextColor;
  int? get getExpiredInMinuets => expiredInMinuets;

  // Setters for modifying private fields and notifying listeners.

  /// Sets the user's API key and notifies listeners of the change.
  set userApiKey(String value) {
    _userApiKey = value;
    notifyListeners();
  }

  /// Sets the loading status for user deletion and notifies listeners of the change.
  set userDeleteLoading(String? value) {
    _userDeleteLoading = value;
    notifyListeners();
  }
  /// Sets the expired time for the payment and notifies listeners of the change.
  set setExpiredInMinuets(int? value) {
    expiredInMinuets = value;
    notifyListeners();
  }

  /// Sets the error message for user deletion and notifies listeners of the change.
  set userDeleteError(String? value) {
    _userDeleteError = value;
    notifyListeners();
  }

  /// Sets the app bar widget for saved cards and notifies listeners of the change.
  set userSavedCardsAppBar(Widget? value) {
    _userSavedCardsAppBar = value;
    notifyListeners();
  }

  /// Sets the user's public key and notifies listeners of the change.
  set userPKey(String value) {
    _userPKey = value;
    notifyListeners();
  }

  /// Sets whether the user chose to save their card and notifies listeners of the change.
  set userSaveCard(bool value) {
    _userSaveCard = value;
    notifyListeners();
  }

  /// Sets the success URL for user operations and notifies listeners of the change.
  set userSuccessUrl(String? value) {
    _userSuccessUrl = value;
    notifyListeners();
  }

  /// Sets the cancel URL for user operations and notifies listeners of the change.
  set userCancelUrl(String? value) {
    _userCancelUrl = value;
    notifyListeners();
  }

  /// Sets the client's ID and notifies listeners of the change.
  set userClintID(String value) {
    _userClintID = value;
    notifyListeners();
  }

  /// Sets the customer's ID and notifies listeners of the change.
  set userCustomerID(String value) {
    _userCustomerID = value;
    notifyListeners();
  }

  /// Sets the loading status for card selection and notifies listeners of the change.
  set userSelectCardLoading(String value) {
    _userSelectCardLoading = value;
    notifyListeners();
  }

  /// Sets whether the test mode is enabled and notifies listeners of the change.
  set isTestMode(bool value) {
    _isTestMode = value;
    notifyListeners();
  }

  /// Sets the list of user products and notifies listeners of the change.
  set userProducts(List<Product> value) {
    _userProducts = value;
    notifyListeners();
  }

  /// Sets the metadata for the user and notifies listeners of the change.
  set userMetadata(Map<String, dynamic> value) {
    _userMetadata = value;
    notifyListeners();
  }

  /// Sets the background color for the saved card widget and notifies listeners of the change.
  set userSavedCardBackground(Color? value) {
    _userSavedCardBackground = value;
    notifyListeners();
  }

  /// Sets the text color for the saved card widget and notifies listeners of the change.
  set userSavedCardTextColor(Color? value) {
    _userSavedCardTextColor = value;
    notifyListeners();
  }
}
