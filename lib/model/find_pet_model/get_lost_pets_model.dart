class GetLostPetsModel {
  late bool status;
  late String message;
  late List<LostPet> lostPets;
  late Pagination pagination;

  GetLostPetsModel({
    required this.status,
    required this.message,
    required this.lostPets,
    required this.pagination,
  });

  factory GetLostPetsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['lostPets'] ?? {};

    return GetLostPetsModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      lostPets: (data['data'] as List<dynamic>?)
          ?.map((item) => LostPet.fromJson(item))
          .toList() ?? [],
      pagination: Pagination.fromJson(data),
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

class LostPet {
  late int id;
  late int userId;
  late String name;
  late int age;
  late String type;
  late String gender;
  late String breed;
  late int found;
  late String lastSeenLocation;
  late String lastSeenTime;
  late String lastSeenInfo;
  late DateTime createdAt;
  late DateTime updatedAt;
  late User user;
  late List<LostPetGallery> lostPetGallery;

  LostPet({
    required this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    required this.breed,
    required this.found,
    required this.lastSeenLocation,
    required this.lastSeenTime,
    required this.lastSeenInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.lostPetGallery,
  });

  factory LostPet.fromJson(Map<String, dynamic> json) {
    return LostPet(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'] ?? '',
      found: json['found'] ?? 0,
      lastSeenLocation: json['lastseen_location'] ?? '',
      lastSeenTime: json['lastseen_time'] ?? '',
      lastSeenInfo: json['lastseen_info'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      user: User.fromJson(json['user'] ?? {}),
      lostPetGallery: (json['lost_pet_gallery'] as List<dynamic>?)
          ?.map((item) => LostPetGallery.fromJson(item))
          .toList() ?? [],

    );
  }
}

class LostPetGallery {
  late int id;
  late int lostPetId;
  late String image;
  late DateTime createdAt;
  late DateTime updatedAt;

  LostPetGallery({
    required this.id,
    required this.lostPetId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LostPetGallery.fromJson(Map<String, dynamic> json) {
    return LostPetGallery(
      id: json['id'] ?? 0,
      lostPetId: json['lost_pet_id'] ?? 0,
      image: json['image'] ?? '',
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
  late String? nextPageUrl;
  late String? prevPageUrl;
  late String path;
  late int perPage;
  late int from;
  late int to;
  late int total;
  late List<Link> links;

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
  late String? url;
  late String label;
  late bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'] ?? '',
      active: json['active'] ?? false,
    );
  }
}
