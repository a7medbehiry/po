class GetMyFoundPetsModel {
  late bool status;
  late String message;
  late List<FoundPet> foundPets;

  // Constructor
  GetMyFoundPetsModel({
    required this.status,
    required this.message,
    required this.foundPets,
  });

  // Factory method to create GetMyFoundPetsModel from JSON
  factory GetMyFoundPetsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['foundpets'] ?? [];

    return GetMyFoundPetsModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      foundPets: (data as List<dynamic>)
          .map((item) => FoundPet.fromJson(item))
          .toList(),
    );
  }
}

class FoundPet {
  late int id;
  late int userId;
  late String type;
  late String gender;
  late String breed;
  late String foundLocation;
  late String foundTime;
  late String foundInfo;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<FoundPetGallery> foundPetGallery;

  // Constructor
  FoundPet({
    required this.id,
    required this.userId,
    required this.type,
    required this.gender,
    required this.breed,
    required this.foundLocation,
    required this.foundTime,
    required this.foundInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.foundPetGallery,
  });

  // Factory method to create FoundPet from JSON
  factory FoundPet.fromJson(Map<String, dynamic> json) {
    return FoundPet(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'] ?? '',
      foundLocation: json['found_location'] ?? '',
      foundTime: json['found_time'] ?? '',
      foundInfo: json['found_info'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      foundPetGallery: (json['found_pet_gallery'] as List<dynamic>?)
          ?.map((item) => FoundPetGallery.fromJson(item))
          .toList() ?? [],
    );
  }
}

class FoundPetGallery {
  late int id;
  late int foundPetId;
  late String image;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  FoundPetGallery({
    required this.id,
    required this.foundPetId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create FoundPetGallery from JSON
  factory FoundPetGallery.fromJson(Map<String, dynamic> json) {
    return FoundPetGallery(
      id: json['id'] ?? 0,
      foundPetId: json['found_pet_id'] ?? 0,
      image: json['image'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
