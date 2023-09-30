class StatusClass {
  bool? success;
  int? code;
  String? description;
  Map? data;
  Map? metadata;

  StatusClass({
    this.success,
    this.code,
    this.data,
    this.description,
    this.metadata,
  });

  StatusClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    description = json['description'];
    data = json['data'];
    metadata = json['metadata'];
  }
}
