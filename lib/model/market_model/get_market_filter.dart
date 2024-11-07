// GetMarketFilterModel Class
class GetMarketFilterModel {
  late bool status;
  late String message;
  late List<Pet> pets;
  late Pagination pagination;

  GetMarketFilterModel({
    required this.status,
    required this.message,
    required this.pets,
    required this.pagination,
  });

  factory GetMarketFilterModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['pets'] as List<dynamic>? ?? [];

    return GetMarketFilterModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      pets: data.map((item) => Pet.fromJson(item)).toList(),
      pagination: Pagination.fromJson(json['data']),
    );
  }
}

// Pet Class
class Pet {
  late int id;
  late int userId;
  late String name;
  late int age;
  late String type;
  late String gender;
  late String? breed; // Nullable
  late String? picture; // Nullable
  late bool forAdoption;
  late String price;
  late DateTime createdAt;
  late DateTime updatedAt;
  late User user;
  late List<dynamic> marketPetGallery;

  Pet({
    required this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.type,
    required this.gender,
    this.breed,
    this.picture,
    required this.forAdoption,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.marketPetGallery,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      breed: json['breed'],
      picture: json['picture'],
      forAdoption: json['for_adoption'] == 1, // Convert to bool
      price: json['price'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      user: User.fromJson(json['user'] ?? {}),
      marketPetGallery: List<dynamic>.from(json['marketpetgallery'] ?? []),
    );
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
  late String? picture; // Nullable
  late bool isEmailVerified;
  late DateTime? emailVerifiedAt; // Nullable
  late String? emailLastVerificationCode; // Nullable
  late DateTime? emailLastVerificationCodeExpiredAt; // Nullable
  late DateTime createdAt;
  late DateTime updatedAt;

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
      emailLastVerificationCodeExpiredAt: DateTime.tryParse(json['email_last_verfication_code_expird_at'] ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}

// Pagination Class
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
      links: (json['links'] as List<dynamic>?)?.map((item) => Link.fromJson(item)).toList() ?? [],
    );
  }
}

// Link Class
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
