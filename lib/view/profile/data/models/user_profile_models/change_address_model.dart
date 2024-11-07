class ChangeAddressModel {
  late bool status;
  late String message;
  UserData? data;

  ChangeAddressModel({
    required this.status,
    required this.message,
    this.data,
  });

  ChangeAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // Check if 'data' is a Map and not null
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = UserData.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

class UserData {
  late User? user;

  UserData({
    required this.user,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null && json['user'] is Map<String, dynamic>
        ? User.fromJson(json['user'])
        : null;
  }
}

class User {
  late String address;

  User({
    required this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }
}
