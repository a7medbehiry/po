class AddGalleryModel {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final List<Pet> data;
  final List<dynamic> notes;

  AddGalleryModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory AddGalleryModel.fromJson(Map<String, dynamic> json) {
    return AddGalleryModel(
      status: json['status'],
      message: json['message'],
      errors: json['errors'] ?? [],
      data: List<Pet>.from(json['data'].map((x) => Pet.fromJson(x))),
      notes: json['notes'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      'data': data.map((x) => x.toJson()).toList(),
      'notes': notes,
    };
  }
}

class Pet {
  final int id;
  final int userId;
  final String name;
  final String age;
  final String type;
  final String gender;
  final String breed;
  final String picture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PetGallery> petGallery;

  Pet({
    required this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    required this.breed,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
    required this.petGallery,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      age: json['age'],
      type: json['type'],
      gender: json['gender'],
      breed: json['breed'],
      picture: json['picture'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      petGallery: List<PetGallery>.from(
          json['petgallery'].map((x) => PetGallery.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'age': age,
      'type': type,
      'gender': gender,
      'breed': breed,
      'picture': picture,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'petgallery': petGallery.map((x) => x.toJson()).toList(),
    };
  }
}

class PetGallery {
  final int id;
  final int petId;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  PetGallery({
    required this.id,
    required this.petId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PetGallery.fromJson(Map<String, dynamic> json) {
    return PetGallery(
      id: json['id'],
      petId: json['pet_id'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_id': petId,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
