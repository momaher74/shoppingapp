class ProfileModel {
  Data? data;

  ProfileModel.fromJson(Map json) {
    data = Data.fromJson(json['data']);
  }
}

class Data {
  String? name;

  String? email;

  String? phone;

  String? image;

  int? points;

  int? id;

  double? credit;

  Data.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
  }
}
