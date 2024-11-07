import 'data.dart';

class GetAllPetsModel {
  bool? status;
  String? message;
  List<dynamic>? errors;
  Data? data;
  List<dynamic>? notes;

  GetAllPetsModel({
    this.status,
    this.message,
    this.errors,
    this.data,
    this.notes,
  });

  factory GetAllPetsModel.fromJson(Map<String, dynamic> json) {
    return GetAllPetsModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] is Map<String, dynamic>
          ? Data.fromJson(json['data'])
          : null,
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
