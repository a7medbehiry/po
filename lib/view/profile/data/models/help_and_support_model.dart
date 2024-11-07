class HelpAndSupportModel {
  late bool status;
  late String message;

  HelpAndSupportModel({
    required this.status,
    required this.message,
  });

  HelpAndSupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
