class NotificationModel {
  NotificationDataModel? data;

  NotificationModel.fromJson(Map json) {
    data = NotificationDataModel.fromJson(json['data']);
  }
}

class NotificationDataModel {
  List data = [];

  NotificationDataModel.fromJson(Map json) {
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;

  String? title;

  String? message;

  DataModel.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }
}
