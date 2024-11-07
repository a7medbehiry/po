class AddBankModel {
  late bool status;
  late String message;

  AddBankModel({
    required this.status,
    required this.message,
  });

  AddBankModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
