class AddYourFoundPet {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final PetData data;
  final List<dynamic> notes;

  AddYourFoundPet({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory AddYourFoundPet.fromJson(Map<String, dynamic> json) {
    return AddYourFoundPet(
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
  final int founderId;
  final String type;
  final String gender;
  final String breed;
  final String foundLocation;
  final String foundTime;
  final String foundInfo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FoundPetGallery> foundPetGallery;
  final Founder founder;

  Pet({
    required this.id,
    required this.userId,
    required this.founderId,
    required this.type,
    required this.gender,
    required this.breed,
    required this.foundLocation,
    required this.foundTime,
    required this.foundInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.foundPetGallery,
    required this.founder,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      founderId: json['founder_id'] as int,
      type: json['type'] as String,
      gender: json['gender'] as String,
      breed: json['breed'] as String,
      foundLocation: json['found_location'] as String,
      foundTime: json['found_time'] as String,
      foundInfo: json['found_info'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      foundPetGallery: (json['found_pet_gallery'] as List<dynamic>)
          .map((gallery) => FoundPetGallery.fromJson(gallery as Map<String, dynamic>))
          .toList(),
      founder: Founder.fromJson(json['founder'] as Map<String, dynamic>),
    );
  }
}

class FoundPetGallery {
  final int id;
  final int foundPetId;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  FoundPetGallery({
    required this.id,
    required this.foundPetId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FoundPetGallery.fromJson(Map<String, dynamic> json) {
    return FoundPetGallery(
      id: json['id'] as int,
      foundPetId: json['found_pet_id'] as int,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class Founder {
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

  Founder({
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

  factory Founder.fromJson(Map<String, dynamic> json) {
    return Founder(
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
