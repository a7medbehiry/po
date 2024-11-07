class AddYourLostPet {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final PetData data;
  final List<dynamic> notes;

  AddYourLostPet({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory AddYourLostPet.fromJson(Map<String, dynamic> json) {
    return AddYourLostPet(
      status: json['status'] as bool,
      message: json['message'] as String,
      errors: json['errors'] as List<dynamic>,
      data: PetData.fromJson(json['data'] as Map<String, dynamic>),
      notes: json['notes'] as List<dynamic>,
    );
  }
}

class PetData {
  final Pet pet;

  PetData({required this.pet});

  factory PetData.fromJson(Map<String, dynamic> json) {
    return PetData(
      pet: Pet.fromJson(json['pet'] as Map<String, dynamic>),
    );
  }
}

class Pet {
  final int id;
  final int userId;
  final int? founderId;
  final String name;
  final int age;
  final String type;
  final String gender;
  final String breed;
  final int found;
  final String lastseenLocation;
  final String lastseenTime;
  final String lastseenInfo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<LostPetGallery> lostPetGallery;
  final User user;

  Pet({
    required this.id,
    required this.userId,
    this.founderId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    required this.breed,
    required this.found,
    required this.lastseenLocation,
    required this.lastseenTime,
    required this.lastseenInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.lostPetGallery,
    required this.user,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    final galleryList = (json['lost_pet_gallery'] as List<dynamic>?)
        ?.map((gallery) => LostPetGallery.fromJson(gallery as Map<String, dynamic>))
        .toList() ??
        [];
    return Pet(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      founderId: json['founder_id'] as int?,
      name: json['name'] as String,
      age: json['age'] as int,
      type: json['type'] as String,
      gender: json['gender'] as String,
      breed: json['breed'] as String,
      found: json['found'] as int,
      lastseenLocation: json['lastseen_location'] as String,
      lastseenTime: json['lastseen_time'] as String,
      lastseenInfo: json['lastseen_info'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lostPetGallery: galleryList,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class LostPetGallery {
  final int id;
  final int lostPetId;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  LostPetGallery({
    required this.id,
    required this.lostPetId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LostPetGallery.fromJson(Map<String, dynamic> json) {
    return LostPetGallery(
      id: json['id'] as int,
      lostPetId: json['lost_pet_id'] as int,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String? picture;
  final int isEmailVerified;
  final DateTime? emailVerifiedAt;
  final String? emailLastVerificationCode;
  final DateTime? emailLastVerificationCodeExpiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    this.picture,
    required this.isEmailVerified,
    this.emailVerifiedAt,
    this.emailLastVerificationCode,
    this.emailLastVerificationCodeExpiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      picture: json['picture'] as String?,
      isEmailVerified: json['is_email_verified'] as int,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      emailLastVerificationCode: json['email_last_verfication_code'] as String?,
      emailLastVerificationCodeExpiredAt: json['email_last_verfication_code_expird_at'] != null
          ? DateTime.parse(json['email_last_verfication_code_expird_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
