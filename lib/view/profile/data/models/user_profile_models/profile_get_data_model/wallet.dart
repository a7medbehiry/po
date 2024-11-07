class Wallet {
  int? id;
  int? userId;
  String? phone;
  String? pin;
  DateTime? createdAt;
  DateTime? updatedAt;

  Wallet({
    this.id,
    this.userId,
    this.phone,
    this.pin,
    this.createdAt,
    this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      phone: json['phone'] as String?,
      pin: json['pin'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'phone': phone,
      'pin': pin,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
