import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  /// Product name (e.g. "I phone 12 pro max")
  String name;
  /// Product quantity (e.g. 2)
  ///
  /// the quantity of the line product,  >=1 <=100
  int quantity;

  /// Product unit amount in Bisa (e.g. 1000 Bisa = 1.000 OMR)
  ///
  /// the price by Baisa, >=100 <=5000000000
  int unitAmount;

  Product({
    required this.name,
    required this.quantity,
    required this.unitAmount,
  });

  Product copyWith({
    String? name,
    int? quantity,
    int? unitAmount,
  }) =>
      Product(
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        unitAmount: unitAmount ?? this.unitAmount,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"],
    quantity: json["quantity"],
    unitAmount: json["unit_amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "unit_amount": unitAmount,
  };
}
