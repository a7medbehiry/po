// GetSearchFilterModel Class
class GetSearchFilterModel {
  late bool status;
  late String message;
  late List<Dog> pets;
  late Pagination pagination;

  // Constructor
  GetSearchFilterModel({
    required this.status,
    required this.message,
    required this.pets,
    required this.pagination,
  });

  // Factory method to create GetSearchFilterModel from JSON
  factory GetSearchFilterModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return GetSearchFilterModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      pets: (data['pets'] as List<dynamic>?)
          ?.map((item) => Dog.fromJson(item))
          .toList() ?? [],
      pagination: Pagination.fromJson(data['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'pets': pets.map((pet) => pet.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

// Dog Class
class Dog {
  late int id;
  late int userId;
  late String name;
  late String age;
  late String type;
  late String gender;
  String? breed; // Nullable
  String? picture; // Nullable
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<PetGallery> petGallery; // Changed to PetGallery
  late User user; // Added the user field
  BreedInfo? breedInfo; // Nullable

  // Constructor
  Dog({
    required this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    this.breed,
    this.picture,
    required this.createdAt,
    required this.updatedAt,
    required this.petGallery,
    required this.user, // Initialize user
    this.breedInfo, // Initialize breedInfo
  });

  // Factory method to create Dog from JSON
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'],
      picture: json['picture'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      petGallery: (json['petgallery'] as List<dynamic>?)
          ?.map((item) => PetGallery.fromJson(item))
          .toList() ?? [],
      user: User.fromJson(json['user'] ?? {}),
      breedInfo: json['breed_info'] != null ? BreedInfo.fromJson(json['breed_info']) : null,
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'petgallery': petGallery.map((gallery) => gallery.toJson()).toList(),
      'user': user.toJson(),
      'breed_info': breedInfo?.toJson(),
    };
  }
}

class BreedInfo {
  late int id;
  late String type;
  late String name;
  late String lifeExpectancy;
  late String weight;
  late String height;
  late String physicalCharacteristics;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  BreedInfo({
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

  // Factory method to create BreedInfo from JSON
  factory BreedInfo.fromJson(Map<String, dynamic> json) {
    return BreedInfo(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      lifeExpectancy: json['life_expectancy'] ?? '',
      weight: json['weight'] ?? '',
      height: json['height'] ?? '',
      physicalCharacteristics: json['physical_charactaristcs'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
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

// User Class
class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String address;
  String? picture; // Nullable
  late bool isEmailVerified;
  DateTime? emailVerifiedAt; // Nullable
  String? emailLastVerificationCode; // Nullable
  DateTime? emailLastVerificationCodeExpiredAt; // Nullable
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    this.picture,
    required this.isEmailVerified,
    this.emailVerifiedAt,
    this.emailLastVerificationCode,
    this.emailLastVerificationCodeExpiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      picture: json['picture'],
      isEmailVerified: json['is_email_verified'] == 1,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      emailLastVerificationCode: json['email_last_verfication_code'],
      emailLastVerificationCodeExpiredAt: json['email_last_verfication_code_expird_at'] != null
          ? DateTime.tryParse(json['email_last_verfication_code_expird_at'])
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'picture': picture,
      'is_email_verified': isEmailVerified,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'email_last_verfication_code': emailLastVerificationCode,
      'email_last_verfication_code_expird_at': emailLastVerificationCodeExpiredAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Pagination Class
class Pagination {
  late int currentPage;
  late int lastPage;
  late String firstPageUrl;
  late String lastPageUrl;
  String? nextPageUrl; // Nullable
  String? prevPageUrl; // Nullable
  late String path;
  late int perPage;
  late int from;
  late int to;
  late int total;
  late List<Link> links;

  // Constructor
  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.firstPageUrl,
    required this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.path,
    required this.perPage,
    required this.from,
    required this.to,
    required this.total,
    required this.links,
  });

  // Factory method to create Pagination from JSON
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      firstPageUrl: json['first_page_url'] ?? '',
      lastPageUrl: json['last_page_url'] ?? '',
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      from: json['from'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
      links: (json['links'] as List<dynamic>?)
          ?.map((item) => Link.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'first_page_url': firstPageUrl,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'prev_page_url': prevPageUrl,
      'path': path,
      'per_page': perPage,
      'from': from,
      'to': to,
      'total': total,
      'links': links.map((link) => link.toJson()).toList(),
    };
  }
}

// Link Class
class Link {
  String? url; // Nullable
  late String label;
  late bool active;

  // Constructor
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  // Factory method to create Link from JSON
  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'] ?? '',
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

// PetGallery Class (Missing from your provided classes)
class PetGallery {
  late int id;
  late int petId;
  late String image;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  PetGallery({
    required this.id,
    required this.petId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create PetGallery from JSON
  factory PetGallery.fromJson(Map<String, dynamic> json) {
    return PetGallery(
      id: json['id'] ?? 0,
      petId: json['pet_id'] ?? 0,
      image: json['image'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_id': petId,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
