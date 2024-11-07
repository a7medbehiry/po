class ChangePasswordModel {
  late bool status;
  late String message;

  ChangePasswordModel({
    required this.status,
    required this.message,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
