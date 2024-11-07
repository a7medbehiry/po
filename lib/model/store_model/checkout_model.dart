class CheckOutModel {
  final bool status;
  final String message;
  final List<String> errors;
  final OrderData data;
  final List<String> notes;

  CheckOutModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) {
    return CheckOutModel(
      status: json['status'],
      message: json['message'],
      errors: List<String>.from(json['errors']),
      data: OrderData.fromJson(json['data']),
      notes: List<String>.from(json['notes']),
    );
  }
}

class OrderData {
  final Order order;
  final User user;

  OrderData({
    required this.order,
    required this.user,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: Order.fromJson(json['order']),
      user: User.fromJson(json['user']),
    );
  }
}

class Order {
  final int userId;
  final double subtotal;
  final int status;
  final String phone;
  final String receipt;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Order({
    required this.userId,
    required this.subtotal,
    required this.status,
    required this.phone,
    required this.receipt,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['user_id'],
      subtotal: json['subtotal'].toDouble(),
      status: json['status'],
      phone: json['phone'],
      receipt: json['receipt'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
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
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      picture: json['picture'],
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
    );
  }
}
