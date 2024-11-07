// Main response model
class SignUpModel {
  final bool status;
  final String message;
  final List<dynamic> errors; // Assuming errors can be of various types
  final SignUpData? data;

  SignUpModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      status: json['status'],
      message: json['message'],
      errors: json['errors'],
      data: json['data'] is Map<String, dynamic>
          ? SignUpData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      'data': data?.toJson(),
      };
  }
}

// Data model
class SignUpData {
  final User user;
  final Pet pet;
  final String token;

  SignUpData({
    required this.user,
    required this.pet,
    required this.token,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      user: User.fromJson(json['user']),
      pet: Pet.fromJson(json['pet']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'pet': pet.toJson(),
      'token': token,
    };
  }
}

// User model
class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int joinedWith;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.joinedWith,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      joinedWith: json['joined_with'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'joined_with': joinedWith,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}

// Pet model
class Pet {
  final int userId;
  final String name;
  final String age;
  final String type;
  final String gender;
  final String breed;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Pet({
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    required this.breed,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      userId: json['user_id'],
      name: json['name'],
      age: json['age'],
      type: json['type'],
      gender: json['gender'],
      breed: json['breed'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'age': age,
      'type': type,
      'gender': gender,
      'breed': breed,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
