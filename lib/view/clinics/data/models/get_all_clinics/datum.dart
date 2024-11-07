class Datum {
  int? id;
  String? clinicName;
  String? doctor;
  String? specialization;
  String? address;
  String? medicalFees;
  String? workingDays;
  String? workingTimes;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.clinicName,
    this.doctor,
    this.specialization,
    this.address,
    this.medicalFees,
    this.workingDays,
    this.workingTimes,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'] as int?,
      clinicName: json['clinic_name'] as String?,
      doctor: json['doctor'] as String?,
      specialization: json['specialization'] as String?,
      address: json['address'] as String?,
      medicalFees: json['medical_fees'] as String?,
      workingDays: json['working_days'] as String?,
      workingTimes: json['working_times'] as String?,
      picture: json['picture'] as String?,
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
      'clinic_name': clinicName,
      'doctor': doctor,
      'specialization': specialization,
      'address': address,
      'medical_fees': medicalFees,
      'working_days': workingDays,
      'working_times': workingTimes,
      'picture': picture,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
