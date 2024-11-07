import 'data.dart';

class GetPetModel {
  bool? status;
  String message;
  List<dynamic>? errors;
  Data? data;
  List<dynamic>? notes;

  GetPetModel({
    this.status,
    required this.message,
    this.errors,
    this.data,
    this.notes,
  });

  factory GetPetModel.fromJson(Map<String, dynamic> json) {
    return GetPetModel(
      status: json['status'] as bool?,
      message: json['message'] as String,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      notes: json['notes'] as List<dynamic>?,
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
