class CheckMailModel {
  late bool status;
  late String message;

  CheckMailModel({
    required this.status,
    required this.message,
  });

  CheckMailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
