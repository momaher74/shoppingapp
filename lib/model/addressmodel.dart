class AddressModel {
  bool? status;

  String? message;

  Data? data;

  AddressModel.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  String? name;

  String? city;

  String? region;

  String? details;

  String? notes;

  dynamic latitude;

  dynamic longitude;

  int? id;

  Data.fromJson(Map json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
  }
}
