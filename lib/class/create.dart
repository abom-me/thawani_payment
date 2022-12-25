class Create {
  bool? success;
  int? code;
  String? description;
  Map? data;

  Create({
    this.success,
    this.code,
    this.data,
    this.description,
  });

  Create.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    description = json['description'];
    data = json['data'];
  }
}
