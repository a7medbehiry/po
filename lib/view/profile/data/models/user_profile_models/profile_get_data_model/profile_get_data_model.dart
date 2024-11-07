import 'dart:convert';

// Main response model
class ProfileGetDataModel {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final UserData data;
  final List<dynamic> notes;

  ProfileGetDataModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory ProfileGetDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileGetDataModel(
      status: json['status'],
      message: json['message'],
      errors: json['errors'],
      data: UserData.fromJson(json['data']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      'data': data.toJson(),
      'notes': notes,
    };
  }
}

// Data model containing user, bankCards, and wallets
class UserData {
  final User user;
  final List<dynamic> bankCards;
  final List<dynamic> wallets;

  UserData({
    required this.user,
    required this.bankCards,
    required this.wallets,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      bankCards: json['bankCards'] ?? [],
      wallets: json['wallets'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'bankCards': bankCards,
      'wallets': wallets,
    };
  }
}

// User model with nullable fields
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  // final String phone;
  final String? picture;
  final int joinedWith;
  final int isEmailVerified;
  final DateTime? emailVerifiedAt;
  final String? emailLastVerificationCode;
  final DateTime? emailLastVerificationCodeExpiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> bankcard;
  final List<dynamic> wallet;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.phone,
    this.picture,
    required this.joinedWith,
    required this.isEmailVerified,
    this.emailVerifiedAt,
    this.emailLastVerificationCode,
    this.emailLastVerificationCodeExpiredAt,
    required this.createdAt,
    required this.updatedAt,
    required this.bankcard,
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      // phone: json['phone'],
      picture: json['picture'],
      joinedWith: json['joined_with'],
      isEmailVerified: json['is_email_verified'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      emailLastVerificationCode: json['email_last_verfication_code'],
      emailLastVerificationCodeExpiredAt:
          json['email_last_verfication_code_expird_at'] != null
              ? DateTime.parse(json['email_last_verfication_code_expird_at'])
              : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bankcard: json['bankcard'] ?? [],
      wallet: json['wallet'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      // 'phone': phone,
      'picture': picture,
      'joined_with': joinedWith,
      'is_email_verified': isEmailVerified,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'email_last_verfication_code': emailLastVerificationCode,
      'email_last_verfication_code_expird_at':
          emailLastVerificationCodeExpiredAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'bankcard': bankcard,
      'wallet': wallet,
    };
  }
}
