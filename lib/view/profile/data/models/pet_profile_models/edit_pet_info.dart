class ChangeProfileInfoModel {
  late bool status;
  late String message;
  UserData? data;

  ChangeProfileInfoModel({
    required this.status,
    required this.message,
    this.data,
  });

  ChangeProfileInfoModel.fromJson(Map<String, dynamic> json) {
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
  late Pet? pet;

  UserData({
    required this.pet,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    pet = json['pet'] != null && json['pet'] is Map<String, dynamic>
        ? Pet.fromJson(json['pet'])
        : null;
  }
}

class Pet {
  late int id;
  late int userId;
  late String age;
  late String type;
  late String gender;
  late String breed;

  Pet({
    required this.id,
    required this.userId,
    required this.age,
    required this.type,
    required this.gender,
    required this.breed,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    type = json['type'];
    gender = json['gender'];
    breed = json['breed'];
    id = json['id'];
    userId = json['user_id'];
  }
}
