class ChangeCartModel {
  bool? status;

  String? message;

  ChangeCartModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
  }
}
