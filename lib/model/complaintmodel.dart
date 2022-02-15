class ComplaintModel {
  bool? status;

  String? message;

  ComplaintData? data;

  ComplaintModel.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = ComplaintData.fromJson(json['data']);
  }
}

class ComplaintData {
  String? name;

  int? phone;

  String? email;

  String? message;

  int? id;

  ComplaintData.fromJson(Map json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    message = json['message'];
    id = json['id'];
  }
}

