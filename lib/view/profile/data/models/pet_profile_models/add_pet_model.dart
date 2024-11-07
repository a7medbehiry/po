class AddPetModel {
  late bool status;
  late String message;
  UserData? data;

  AddPetModel({
    required this.status,
    required this.message,
    this.data,
  });

  AddPetModel.fromJson(Map<String, dynamic> json) {
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

  UserData({required this.pet});

  UserData.fromJson(Map<String, dynamic> json) {
    pet = json['pet'] != null && json['pet'] is Map<String, dynamic>
        ? Pet.fromJson(json['pet'])
        : null;
  }
}

class Pet {
  late int userId;
  late String name;
  late String age;
  late String type;
  late String gender;
  late String breed;
  late String picture;
  late int id;

  Pet({
    required this.name,
    required this.age,
    required this.userId,
    required this.type,
    required this.gender,
    required this.breed,
    required this.picture,
    required this.id,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    age = json['age'];
    type = json['type'];
    gender = json['gender'];
    breed = json['breed'];
    picture = json['picture'];
    id = json['id'];
  }
}
