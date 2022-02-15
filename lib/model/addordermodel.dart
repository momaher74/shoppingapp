class AddOrderModel {
  bool? status;

  String? message;
  DataModel? data;

  AddOrderModel.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  String? method;

  dynamic cost;

  dynamic discount;

  dynamic points;

  dynamic total;

  int? id;

  DataModel.fromJson(Map json) {
    method = json['payment_method'];
    cost = json['cost'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }
}
