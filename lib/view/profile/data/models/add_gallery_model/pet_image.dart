class PetImage {
  int? id;
  int? petId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  PetImage({
    this.id,
    this.petId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory PetImage.fromJson(Map<String, dynamic> json) {
    return PetImage(
      id: json['id'] as int?,
      petId: json['pet_id'] as int?,
      image: json['image'] as String?,
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
      'pet_id': petId,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
