import 'petgallery.dart';

class Animal {
  int? id;
  int? userId;
  String? name;
  int? age;
  String? type;
  String? gender;
  dynamic breed;
  dynamic picture;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Petgallery>? petgallery;

  Animal({
    this.id,
    this.userId,
    this.name,
    this.age,
    this.type,
    this.gender,
    this.breed,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.petgallery,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      type: json['type'] as String?,
      gender: json['gender'] as String?,
      breed: json['breed'] as dynamic,
      picture: json['picture'] as dynamic,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      petgallery: (json['petgallery'] as List<dynamic>?)
          ?.map((e) => Petgallery.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'age': age,
      'type': type,
      'gender': gender,
      'breed': breed,
      'picture': picture,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'petgallery': petgallery?.map((e) => e.toJson()).toList(),
    };
  }
}
