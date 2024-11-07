// GetStoreDataModel Class
class GetStoreDataModel {
  late bool status;
  late String message;
  late List<String> errors;
  late StoreData data;
  late List<String> notes;

  // Constructor
  GetStoreDataModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  // Factory method to create GetStoreDataModel from JSON
  factory GetStoreDataModel.fromJson(Map<String, dynamic> json) {
    return GetStoreDataModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      errors: List<String>.from(json['errors'] ?? []),
      data: StoreData.fromJson(json['data'] ?? {}),
      notes: List<String>.from(json['notes'] ?? []),
    );
  }
}

// StoreData Class
class StoreData {
  late Store store;

  // Constructor
  StoreData({
    required this.store,
  });

  // Factory method to create StoreData from JSON
  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      store: Store.fromJson(json['store'] ?? {}),
    );
  }
}

// Store Class
class Store {
  late int id;
  late String name;
  late String picture;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String description;
  late List<Category> categories;

  // Constructor
  Store({
    required this.id,
    required this.name,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.categories,
  });

  // Factory method to create Store from JSON
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      description: json['description'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((item) => Category.fromJson(item))
          .toList() ??
          [],
    );
  }
}

// Category Class
class Category {
  late int id;
  late String name;
  late String? image; // Nullable
  late String? notes; // Nullable
  late DateTime createdAt;
  late DateTime updatedAt;
  late int storeId;
  late List<Product> products;

  // Constructor
  Category({
    required this.id,
    required this.name,
    this.image,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.storeId,
    required this.products,
  });

  // Factory method to create Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'],
      notes: json['notes'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      storeId: json['store_id'] ?? 0,
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item))
          .toList() ??
          [],
    );
  }
}

// Product Class
class Product {
  late int id;
  late int storeId;
  late int categoryId;
  late String name;
  late String description;
  late String type;
  late String price;
  late int quantity;
  late DateTime createdAt;
  late DateTime updatedAt;
  late int offer;
  late int? saleAmount; // Nullable

  // Constructor
  Product({
    required this.id,
    required this.storeId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.offer,
    this.saleAmount,
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      storeId: json['store_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      offer: json['offer'] ?? 0,
      saleAmount: json['sale_amount'] != null
          ? int.tryParse(json['sale_amount'].toString())
          : null,
    );
  }
}
