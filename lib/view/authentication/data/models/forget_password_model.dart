class ForgetPasswordModel {
  late bool status;
  late String message;

  ForgetPasswordModel({
    required this.status,
    required this.message,
  });

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
