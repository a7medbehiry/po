class GetBreedModel {
  final bool status;
  final String message;
  final List<dynamic> errors;
  final Data data;
  final List<dynamic> notes;

  GetBreedModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  factory GetBreedModel.fromJson(Map<String, dynamic> json) {
    return GetBreedModel(
      status: json['status'],
      message: json['message'],
      errors: List<dynamic>.from(json['errors']),
      data: Data.fromJson(json['data']),
      notes: List<dynamic>.from(json['notes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      'data': data.toJson(),
      'notes': notes,
    };
  }
}

class Data {
  final List<Breed> breeds;

  Data({
    required this.breeds,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      breeds: List<Breed>.from(json['breeds'].map((x) => Breed.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breeds': List<dynamic>.from(breeds.map((x) => x.toJson())),
    };
  }
}

class Breed {
  final int id;
  final String type;
  final String name;
  final String lifeExpectancy;
  final String weight;
  final String height;
  final String physicalCharacteristics;
  final DateTime createdAt;
  final DateTime updatedAt;

  Breed({
    required this.id,
    required this.type,
    required this.name,
    required this.lifeExpectancy,
    required this.weight,
    required this.height,
    required this.physicalCharacteristics,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      lifeExpectancy: json['life_expectancy'],
      weight: json['weight'],
      height: json['height'],
      physicalCharacteristics: json['physical_charactaristcs'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'life_expectancy': lifeExpectancy,
      'weight': weight,
      'height': height,
      'physical_charactaristcs': physicalCharacteristics,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
