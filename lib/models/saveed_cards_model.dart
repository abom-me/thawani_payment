// To parse this JSON data, do
//
//     final savedCardsModel = savedCardsModelFromJson(jsonString);

import 'dart:convert';

SavedCardsModel savedCardsModelFromJson(String str) =>
    SavedCardsModel.fromJson(json.decode(str));

String savedCardsModelToJson(SavedCardsModel data) =>
    json.encode(data.toJson());

class SavedCardsModel {
  bool? success;
  int? code;
  String? description;
  List<CardData>? data;

  SavedCardsModel({
    this.success,
    this.code,
    this.description,
    this.data,
  });

  SavedCardsModel copyWith({
    bool? success,
    int? code,
    String? description,
    List<CardData>? data,
  }) =>
      SavedCardsModel(
        success: success ?? this.success,
        code: code ?? this.code,
        description: description ?? this.description,
        data: data ?? this.data,
      );

  factory SavedCardsModel.fromJson(Map<String, dynamic> json) =>
      SavedCardsModel(
        success: json["success"],
        code: json["code"],
        description: json["description"],
        data: json["data"] == null
            ? []
            : List<CardData>.from(
                json["data"]!.map((x) => CardData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "description": description,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CardData {
  String? id;
  int? bin;
  String? maskedCard;
  int? expiryMonth;
  int? expiryYear;
  String? nickname;
  String? brand;
  String? cardType;
  Customer? customer;

  CardData({
    this.id,
    this.bin,
    this.maskedCard,
    this.expiryMonth,
    this.expiryYear,
    this.nickname,
    this.brand,
    this.cardType,
    this.customer,
  });

  CardData copyWith({
    String? id,
    int? bin,
    String? maskedCard,
    int? expiryMonth,
    int? expiryYear,
    String? nickname,
    String? brand,
    String? cardType,
    Customer? customer,
  }) =>
      CardData(
        id: id ?? this.id,
        bin: bin ?? this.bin,
        maskedCard: maskedCard ?? this.maskedCard,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        nickname: nickname ?? this.nickname,
        brand: brand ?? this.brand,
        cardType: cardType ?? this.cardType,
        customer: customer ?? this.customer,
      );

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        id: json["id"],
        bin: json["bin"],
        maskedCard: json["masked_card"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        nickname: json["nickname"],
        brand: json["brand"],
        cardType: json["card_type"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bin": bin,
        "masked_card": maskedCard,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "nickname": nickname,
        "brand": brand,
        "card_type": cardType,
        "customer": customer?.toJson(),
      };
}

class Customer {
  String? id;
  String? customerClientId;

  Customer({
    this.id,
    this.customerClientId,
  });

  Customer copyWith({
    String? id,
    String? customerClientId,
  }) =>
      Customer(
        id: id ?? this.id,
        customerClientId: customerClientId ?? this.customerClientId,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerClientId: json["customer_client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_client_id": customerClientId,
      };
}
