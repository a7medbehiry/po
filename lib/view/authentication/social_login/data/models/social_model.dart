// Main Response Model
class SocialModel {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final Data? data;
  final List<dynamic> notes;

  SocialModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      errors: json['errors'] as List<dynamic>,
      data: json['data'] is Map<String, dynamic>
          ? Data.fromJson(json['data'])
          : null,
      notes: json['notes'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      'data': data?.toJson(),
      'notes': notes,
    };
  }
}

// Data Model
class Data {
  final User user;
  final String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json['user']),
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}

// User Model
class User {
  final String firstName;
  final String lastName;
  final String email;
  final int joinedWith;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.joinedWith,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      joinedWith: json['joined_with'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'joined_with': joinedWith,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
