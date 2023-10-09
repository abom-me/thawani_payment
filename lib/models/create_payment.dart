// To parse this JSON data, do
//
//     final createPaymentModel = createPaymentModelFromJson(jsonString);

import 'dart:convert';

CreatePaymentModel createPaymentModelFromJson(String str) =>
    CreatePaymentModel.fromJson(json.decode(str));

String createPaymentModelToJson(CreatePaymentModel data) =>
    json.encode(data.toJson());

class CreatePaymentModel {
  bool? success;
  int? code;
  String? description;
  Data? data;

  CreatePaymentModel({
    this.success,
    this.code,
    this.description,
    this.data,
  });

  CreatePaymentModel copyWith({
    bool? success,
    int? code,
    String? description,
    Data? data,
  }) =>
      CreatePaymentModel(
        success: success ?? this.success,
        code: code ?? this.code,
        description: description ?? this.description,
        data: data ?? this.data,
      );

  factory CreatePaymentModel.fromJson(Map<String, dynamic> json) =>
      CreatePaymentModel(
        success: json["success"],
        code: json["code"],
        description: json["description"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "description": description,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? clientReferenceId;
  int? amount;
  String? currency;
  String? paymentMethod;
  dynamic nextAction;
  String? status;
  Metadata? metadata;
  DateTime? createdAt;
  DateTime? expireAt;

  Data({
    this.id,
    this.clientReferenceId,
    this.amount,
    this.currency,
    this.paymentMethod,
    this.nextAction,
    this.status,
    this.metadata,
    this.createdAt,
    this.expireAt,
  });

  Data copyWith({
    String? id,
    String? clientReferenceId,
    int? amount,
    String? currency,
    String? paymentMethod,
    dynamic nextAction,
    String? status,
    Metadata? metadata,
    DateTime? createdAt,
    DateTime? expireAt,
  }) =>
      Data(
        id: id ?? this.id,
        clientReferenceId: clientReferenceId ?? this.clientReferenceId,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        nextAction: nextAction ?? this.nextAction,
        status: status ?? this.status,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        expireAt: expireAt ?? this.expireAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        clientReferenceId: json["client_reference_id"],
        amount: json["amount"],
        currency: json["currency"],
        paymentMethod: json["payment_method"],
        nextAction: json["next_action"],
        status: json["status"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        expireAt: json["expire_at"] == null
            ? null
            : DateTime.parse(json["expire_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_reference_id": clientReferenceId,
        "amount": amount,
        "currency": currency,
        "payment_method": paymentMethod,
        "next_action": nextAction,
        "status": status,
        "metadata": metadata?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "expire_at": expireAt?.toIso8601String(),
      };
}

class Metadata {
  String? customer;

  Metadata({
    this.customer,
  });

  Metadata copyWith({
    String? customer,
  }) =>
      Metadata(
        customer: customer ?? this.customer,
      );

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        customer: json["customer"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer,
      };
}
