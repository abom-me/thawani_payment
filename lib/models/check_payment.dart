// To parse this JSON data, do
//
//     final checkPaymentModel = checkPaymentModelFromJson(jsonString);

import 'dart:convert';

CheckPaymentModel checkPaymentModelFromJson(String str) =>
    CheckPaymentModel.fromJson(json.decode(str));

String checkPaymentModelToJson(CheckPaymentModel data) =>
    json.encode(data.toJson());

class CheckPaymentModel {
  bool? success;
  int? code;
  String? description;
  Data? data;

  CheckPaymentModel({
    this.success,
    this.code,
    this.description,
    this.data,
  });

  CheckPaymentModel copyWith({
    bool? success,
    int? code,
    String? description,
    Data? data,
  }) =>
      CheckPaymentModel(
        success: success ?? this.success,
        code: code ?? this.code,
        description: description ?? this.description,
        data: data ?? this.data,
      );

  factory CheckPaymentModel.fromJson(Map<String, dynamic> json) =>
      CheckPaymentModel(
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
  NextAction? nextAction;
  String? status;
  Map<String, dynamic>? metadata;
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
    NextAction? nextAction,
    String? status,
    Map<String, dynamic>? metadata,
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
        nextAction: json["next_action"] == null
            ? null
            : NextAction.fromJson(json["next_action"]),
        status: json["status"],
        metadata: json["metadata"],
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
        "next_action": nextAction?.toJson(),
        "status": status,
        "metadata": metadata,
        "created_at": createdAt?.toIso8601String(),
        "expire_at": expireAt?.toIso8601String(),
      };
}

class NextAction {
  String? url;
  String? returnUrl;

  NextAction({
    this.url,
    this.returnUrl,
  });

  NextAction copyWith({
    String? url,
    String? returnUrl,
  }) =>
      NextAction(
        url: url ?? this.url,
        returnUrl: returnUrl ?? this.returnUrl,
      );

  factory NextAction.fromJson(Map<String, dynamic> json) => NextAction(
        url: json["url"],
        returnUrl: json["return_url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "return_url": returnUrl,
      };
}
