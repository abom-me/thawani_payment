// To parse this JSON data, do
//
//     final createCustomerModel = createCustomerModelFromJson(jsonString);

import 'dart:convert';

CreateCustomerModel createCustomerModelFromJson(String str) =>
    CreateCustomerModel.fromJson(json.decode(str));

String createCustomerModelToJson(CreateCustomerModel data) =>
    json.encode(data.toJson());

class CreateCustomerModel {
  bool? success;
  int? code;
  String? description;
  Data? data;

  CreateCustomerModel({
    this.success,
    this.code,
    this.description,
    this.data,
  });

  CreateCustomerModel copyWith({
    bool? success,
    int? code,
    String? description,
    Data? data,
  }) =>
      CreateCustomerModel(
        success: success ?? this.success,
        code: code ?? this.code,
        description: description ?? this.description,
        data: data ?? this.data,
      );

  factory CreateCustomerModel.fromJson(Map<String, dynamic> json) =>
      CreateCustomerModel(
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
  String? customerClientId;

  Data({
    this.id,
    this.customerClientId,
  });

  Data copyWith({
    String? id,
    String? customerClientId,
  }) =>
      Data(
        id: id ?? this.id,
        customerClientId: customerClientId ?? this.customerClientId,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerClientId: json["customer_client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_client_id": customerClientId,
      };
}
