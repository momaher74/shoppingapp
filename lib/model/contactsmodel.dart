class ContactsModel {
  ContactsData? data;

  ContactsModel.fromJson(Map json) {
    data = ContactsData.fromJson(json['data']);
  }
}

class ContactsData {
  List data = [];

  ContactsData.fromJson(json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  String? value;

  String? image;

  Data.fromJson(Map json) {
    value = json['value'];
    image = json['image'];
  }
}
