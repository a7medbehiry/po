class GetNumberModel {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final PaymentData ?data;
  final List<dynamic> notes;

  GetNumberModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory GetNumberModel.fromJson(Map<String, dynamic> json) {
    return GetNumberModel(
      status: json['status'],
      message: json['message'],
      errors: List<dynamic>.from(json['errors']),
      data: json['data'] is Map<String, dynamic>
          ? PaymentData.fromJson(json['data'])
          : null,
      notes: List<dynamic>.from(json['notes']),
    );
  }
}

class PaymentData {
  final Payment payment;

  PaymentData({required this.payment});

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      payment: Payment.fromJson(json['payment']),
    );
  }
}

class Payment {
  final int id;
  final String name;
  final String number;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.name,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
