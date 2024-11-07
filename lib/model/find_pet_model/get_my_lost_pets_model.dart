class GetMyLostPetsModel {
  late bool status;
  late String message;
  late List<LostPet> lostPets;

  // Constructor
  GetMyLostPetsModel({
    required this.status,
    required this.message,
    required this.lostPets,
  });

  // Factory method to create GetMyLostPetsModel from JSON
  factory GetMyLostPetsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['lostpets'] ?? [];

    return GetMyLostPetsModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      lostPets: (data as List<dynamic>)
          .map((item) => LostPet.fromJson(item))
          .toList(),
    );
  }
}

class LostPet {
  late int id;
  late int userId;
  late String name;
  late int age;
  late String type;
  late String gender;
  late String breed;
  late int found;
  late String lastSeenLocation;
  late String lastSeenTime;
  late String lastSeenInfo;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<LostPetGallery> lostPetGallery;

  // Constructor
  LostPet({
    required this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    required this.breed,
    required this.found,
    required this.lastSeenLocation,
    required this.lastSeenTime,
    required this.lastSeenInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.lostPetGallery,
  });

  // Factory method to create LostPet from JSON
  factory LostPet.fromJson(Map<String, dynamic> json) {
    return LostPet(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'] ?? '',
      found: json['found'] ?? 0,
      lastSeenLocation: json['lastseen_location'] ?? '',
      lastSeenTime: json['lastseen_time'] ?? '',
      lastSeenInfo: json['lastseen_info'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      lostPetGallery: (json['lost_pet_gallery'] as List<dynamic>?)
          ?.map((item) => LostPetGallery.fromJson(item))
          .toList() ?? [],
    );
  }
}

class LostPetGallery {
  late int id;
  late int lostPetId;
  late String image;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  LostPetGallery({
    required this.id,
    required this.lostPetId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create LostPetGallery from JSON
  factory LostPetGallery.fromJson(Map<String, dynamic> json) {
    return LostPetGallery(
      id: json['id'] ?? 0,
      lostPetId: json['lost_pet_id'] ?? 0,
      image: json['image'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
