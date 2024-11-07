import 'data.dart';

class GetAllClinicsModel {
  bool? status;
  String? message;
  List<dynamic>? errors;
  Data? data;
  List<dynamic>? notes;

  GetAllClinicsModel({
    this.status,
    this.message,
    this.errors,
    this.data,
    this.notes,
  });

  factory GetAllClinicsModel.fromJson(Map<String, dynamic> json) {
    return GetAllClinicsModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      errors: (json['errors'] is List)
          ? json['errors'] as List<dynamic>?
          : <dynamic>[], // Default to an empty list if not a List
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      notes: (json['notes'] is List)
          ? json['notes'] as List<dynamic>?
          : <dynamic>[], // Default to an empty list if not a List
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
