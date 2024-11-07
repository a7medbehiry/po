class BankCard {
  int? id;
  int? userId;
  String? cardholderName;
  String? cardNumber;
  String? expiryDate;
  String? encryptedCvv;
  DateTime? createdAt;
  DateTime? updatedAt;

  BankCard({
    this.id,
    this.userId,
    this.cardholderName,
    this.cardNumber,
    this.expiryDate,
    this.encryptedCvv,
    this.createdAt,
    this.updatedAt,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      cardholderName: json['cardholder_name'] as String?,
      cardNumber: json['card_number'] as String?,
      expiryDate: json['expiry_date'] as String?,
      encryptedCvv: json['encrypted_cvv'] as String?,
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
      'cardholder_name': cardholderName,
      'card_number': cardNumber,
      'expiry_date': expiryDate,
      'encrypted_cvv': encryptedCvv,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
