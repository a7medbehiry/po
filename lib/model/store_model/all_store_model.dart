// GetAllStoreModel Class
class GetAllStoreModel {
  late bool status;
  late String message;
  late List<Store> stores;
  late Pagination pagination;

  // Constructor
  GetAllStoreModel({
    required this.status,
    required this.message,
    required this.stores,
    required this.pagination,
  });

  // Factory method to create GetAllStoreModel from JSON
  factory GetAllStoreModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?['stores'] ?? {};

    return GetAllStoreModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      stores: (data['data'] as List<dynamic>?)?.map((item) => Store.fromJson(item)).toList() ?? [],
      pagination: Pagination.fromJson(data),
    );
  }
}

// Store Class
class Store {
  late int id;
  late String name;
  late String? picture; // Nullable
  late String description;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<Category> categories; // List of categories

  // Constructor
  Store({
    required this.id,
    required this.name,
    this.picture,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
  });

  // Factory method to create Store from JSON
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      picture: json['picture'],
      description: json['description'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      categories: (json['categories'] as List<dynamic>?)?.map((item) => Category.fromJson(item)).toList() ?? [],
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
  late List<Product> products; // List of products

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
      products: (json['products'] as List<dynamic>?)?.map((item) => Product.fromJson(item)).toList() ?? [],
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
  late String? saleAmount; // Nullable
  late List<ProductImage> productImages; // List of product images


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
    required this.productImages,

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
      saleAmount: json['sale_amount']?.toString(),
      productImages: json['product_images'] != null
          ? (json['product_images'] as List<dynamic>)
          .map((item) => ProductImage.fromJson(item))
          .toList()
          : <ProductImage>[],
    );
  }
}

class ProductImage {
  late int id;
  late int productId;
  late String image;
  late String? notes; // Nullable
  late DateTime createdAt;
  late DateTime updatedAt;

  // Constructor
  ProductImage({
    required this.id,
    required this.productId,
    required this.image,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create ProductImage from JSON
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      image: json['image'] ?? '',
      notes: json['notes'],
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
