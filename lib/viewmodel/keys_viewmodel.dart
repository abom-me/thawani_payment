import 'package:flutter/material.dart';
import 'package:thawani_payment/models/products.dart';

late String userApiKey;
String? userDeleteLoading;
String? userDeleteError;
Widget? userSavedCardsAppBar;
late String userPKey;
late bool userSaveCard;
late String? userSuccessUrl;
late String? userCancelUrl;
late String userClintID;
late String userCustomerID;
late String userSelectCardLoading;
bool isTestMode = false;
late List<Product> userProducts;
late Map<String, dynamic> userMetadata;

Color? userSavedCardBackground;
Color? userSavedCardTextColor;
