class PetPicModel {
  late bool status;
  late String message;
  UserData? data;

  PetPicModel({
    required this.status,
    required this.message,
    this.data,
  });

  PetPicModel.fromJson(Map<String, dynamic> json) {
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
  late String picture;
  late int id;
  late int userId;

  Pet({
    required this.picture,
    required this.id,
    required this.userId,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
    id = json['id'];
    userId = json['user_id'];
  }
}
