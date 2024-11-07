class AddWalletModel {
  late bool status;
  late String message;

  AddWalletModel({
    required this.status,
    required this.message,
  });

  AddWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
