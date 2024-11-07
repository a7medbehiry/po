import 'clinics.dart';

class Data {
  Clinics? clinics;

  Data({this.clinics});

  factory Data.fromJson(
      Map<String, dynamic> json) {
    return Data(
      clinics: json['clinics'] == null
          ? null
          : Clinics
              .fromJson(
                  json['clinics'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic>
      toJson() {
    return {
      'clinics': clinics
          ?.toJson(),
    };
  }
}
