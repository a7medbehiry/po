class CreateNewPasswordModel {
  late bool status;
  late String message;

  CreateNewPasswordModel({
    required this.status,
    required this.message,
  });

  CreateNewPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
