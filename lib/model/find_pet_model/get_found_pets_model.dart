class GetFoundPetsModel {
  late bool status;
  late String message;
  late List<FoundPet> foundPets;
  late Pagination pagination;

  // Constructor
  GetFoundPetsModel({
    required this.status,
    required this.message,
    required this.foundPets,
    required this.pagination,
  });

  // Factory method to create GetFoundPetsModel from JSON
  factory GetFoundPetsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['foundPets'] ?? {};

    return GetFoundPetsModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      foundPets: (data['data'] as List<dynamic>?)
          ?.map((item) => FoundPet.fromJson(item))
          .toList() ?? [],
      pagination: Pagination.fromJson(data),
    );
  }
}
class FoundPet {
  late int id;
  late int userId;
  late String type;
  late String gender;
  late String breed;
  late String foundLocation;
  late String foundTime;
  late String foundInfo;
  late DateTime createdAt;
  late DateTime updatedAt;
  late User user;
  late List<FoundPetGallery> foundPetGallery;

  // Constructor
  FoundPet({
    required this.id,
    required this.userId,
    required this.type,
    required this.gender,
    required this.breed,
    required this.foundLocation,
    required this.foundTime,
    required this.foundInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.foundPetGallery,
  });

  // Factory method to create FoundPet from JSON
  factory FoundPet.fromJson(Map<String, dynamic> json) {
    return FoundPet(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'] ?? '',
      foundLocation: json['found_location'] ?? '',
      foundTime: json['found_time'] ?? '',
      foundInfo: json['found_info'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      user: User.fromJson(json['user'] ?? {}),
      foundPetGallery: (json['found_pet_gallery'] as List<dynamic>?)
          ?.map((item) => FoundPetGallery.fromJson(item))
          .toList() ?? [],
    );
  }
}
class FoundPetGallery {
  late int id;
  late int foundPetId;
  late String image;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  FoundPetGallery({
    required this.id,
    required this.foundPetId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create FoundPetGallery from JSON
  factory FoundPetGallery.fromJson(Map<String, dynamic> json) {
    return FoundPetGallery(
      id: json['id'] ?? 0,
      foundPetId: json['found_pet_id'] ?? 0,
      image: json['image'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String address;
  late String? picture; // Nullable
  late bool isEmailVerified;
  late DateTime? emailVerifiedAt; // Nullable
  late String? emailLastVerificationCode; // Nullable
  late DateTime? emailLastVerificationCodeExpiredAt; // Nullable
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
      emailVerifiedAt: DateTime.tryParse(json['email_verified_at'] ?? ''),
      emailLastVerificationCode: json['email_last_verfication_code'],
      emailLastVerificationCodeExpiredAt:
      DateTime.tryParse(json['email_last_verfication_code_expird_at'] ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
class Pagination {
  late int currentPage;
  late int lastPage;
  late String firstPageUrl;
  late String lastPageUrl;
  late String? nextPageUrl; // Nullable
  late String? prevPageUrl; // Nullable
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
}

class Link {
  late String? url; // Nullable
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
}
