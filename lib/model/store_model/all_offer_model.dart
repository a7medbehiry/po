// GetAllOfferModel Class
class GetAllOfferModel {
  late bool status;
  late String message;
  late List<String> errors;
  late OffersData data;
  late List<String> notes;

  // Constructor
  GetAllOfferModel({
    required this.status,
    required this.message,
    required this.errors,
    required this.data,
    required this.notes,
  });

  // Factory method to create GetAllOfferModel from JSON
  factory GetAllOfferModel.fromJson(Map<String, dynamic> json) {
    return GetAllOfferModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      errors: List<String>.from(json['errors'] ?? []),
      data: OffersData.fromJson(json['data'] ?? {}),
      notes: List<String>.from(json['notes'] ?? []),
    );
  }
}

// OffersData Class
class OffersData {
  late List<Offer> offers;

  // Constructor
  OffersData({
    required this.offers,
  });

  // Factory method to create OffersData from JSON
  factory OffersData.fromJson(Map<String, dynamic> json) {
    return OffersData(
      offers: (json['offers'] as List<dynamic>?)
          ?.map((item) => Offer.fromJson(item))
          .toList() ??
          [],
    );
  }
}

// Offer Class
class Offer {
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
  late int saleAmount;
  late ProductImage firstImage;

  // Constructor
  Offer({
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
    required this.saleAmount,
    required this.firstImage,
  });

  // Factory method to create Offer from JSON
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
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
      saleAmount: json['sale_amount'] ?? 0,
      firstImage: ProductImage.fromJson(json['firstImage'] ?? {}),
    );
  }
}

// ProductImage Class
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
