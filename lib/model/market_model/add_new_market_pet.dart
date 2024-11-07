// AddNewMarketPetModel Class
class AddNewMarketPetModel {
  late bool status;
  late String message;
  late List<String> errors;
  late Data data;
  late List<String> notes;

  // Constructor
  AddNewMarketPetModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  // Factory method to create AddNewMarketPetModel from JSON
  factory AddNewMarketPetModel.fromJson(Map<String, dynamic> json) {
    return AddNewMarketPetModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      errors: List<String>.from(json['errors'] ?? []),
      data: Data.fromJson(json['data'] ?? {}),
      notes: List<String>.from(json['notes'] ?? []),
    );
  }
}

// Data Class
class Data {
  late User user;
  late Pet pet;

  // Constructor
  Data({
    required this.user,
    required this.pet,
  });

  // Factory method to create Data from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json['user'] ?? {}),
      pet: Pet.fromJson(json['pet'] ?? {}),
    );
  }
}

// User Class
class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String address;
  late String? picture; // Nullable
  late bool isEmailVerified;
  late DateTime? emailVerifiedAt; // Nullable
  late String? emailLastVerificationCode; // Nullable
  late DateTime? emailLastVerificationCodeExpiredAt; // Nullable
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
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

  // Factory method to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      picture: json['picture'],
      isEmailVerified: json['is_email_verified'] == 1,
      emailVerifiedAt: DateTime.tryParse(json['email_verified_at'] ?? ''),
      emailLastVerificationCode: json['email_last_verfication_code'],
      emailLastVerificationCodeExpiredAt: DateTime.tryParse(json['email_last_verfication_code_expird_at'] ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}

// Pet Class
class Pet {
  late int id;
  late int userId;
  late String name;
  late int age;
  late String type;
  late String gender;
  late String? breed; // Nullable
  late bool forAdoption;
  late String price;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  Pet({
    required this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    this.breed,
    required this.forAdoption,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create Pet from JSON
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      age: int.tryParse(json['age'] ?? '0') ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'],
      forAdoption: json['for_adoption'] == '1',
      price: json['price'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
