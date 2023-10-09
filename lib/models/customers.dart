// To parse this JSON data, do
//
//     final customersModel = customersModelFromJson(jsonString);

import 'dart:convert';

CustomersModel customersModelFromJson(String str) =>
    CustomersModel.fromJson(json.decode(str));

String customersModelToJson(CustomersModel data) => json.encode(data.toJson());

class CustomersModel {
  bool? success;
  int? code;
  String? description;
  List<Datum>? data;

  CustomersModel({
    this.success,
    this.code,
    this.description,
    this.data,
  });

  CustomersModel copyWith({
    bool? success,
    int? code,
    String? description,
    List<Datum>? data,
  }) =>
      CustomersModel(
        success: success ?? this.success,
        code: code ?? this.code,
        description: description ?? this.description,
        data: data ?? this.data,
      );

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
        success: json["success"],
        code: json["code"],
        description: json["description"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  String? id;
  String? customerClientId;

  Datum({
    this.id,
    this.customerClientId,
  });

  Datum copyWith({
    String? id,
    String? customerClientId,
  }) =>
      Datum(
        id: id ?? this.id,
        customerClientId: customerClientId ?? this.customerClientId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerClientId: json["customer_client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_client_id": customerClientId,
      };
}
