class LogOutModel {
  late bool status;
  late String message;

  LogOutModel({
    required this.status,
    required this.message,
  });

  LogOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
