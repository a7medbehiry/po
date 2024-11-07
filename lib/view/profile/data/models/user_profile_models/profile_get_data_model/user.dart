import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/bank_card.dart';

import 'wallet.dart';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  dynamic picture;
  int? isEmailVerified;
  dynamic emailVerifiedAt;
  String? emailLastVerficationCode;
  String? emailLastVerficationCodeExpirdAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BankCard>? bankcard;
  List<Wallet>? wallet;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.picture,
    this.isEmailVerified,
    this.emailVerifiedAt,
    this.emailLastVerficationCode,
    this.emailLastVerficationCodeExpirdAt,
    this.createdAt,
    this.updatedAt,
    this.bankcard,
    this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      picture: json['picture'] as dynamic,
      isEmailVerified: json['is_email_verified'] as int?,
      emailVerifiedAt: json['email_verified_at'] as dynamic,
      emailLastVerficationCode: json['email_last_verfication_code'] as String?,
      emailLastVerficationCodeExpirdAt:
          json['email_last_verfication_code_expird_at'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      bankcard: (json['bankcard'] as List<dynamic>?)
          ?.map((e) => BankCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallet: (json['wallet'] as List<dynamic>?)
          ?.map((e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'picture': picture,
      'is_email_verified': isEmailVerified,
      'email_verified_at': emailVerifiedAt,
      'email_last_verfication_code': emailLastVerficationCode,
      'email_last_verfication_code_expird_at': emailLastVerficationCodeExpirdAt,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'bankcard': bankcard?.map((e) => e.toJson()).toList(),
      'wallet': wallet?.map((e) => e.toJson()).toList(),
    };
  }
}
