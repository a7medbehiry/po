class CartModel {
  bool status;
  String message;
  List<dynamic> errors;
  CartData? data;
  List<dynamic> notes;

  CartModel({
    required this.status,
    required this.message,
    required this.errors,
    this.data,
    required this.notes,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'],
      message: json['message'],
      errors: json['errors'] ?? [],
      data: json['data'] is Map<String, dynamic>
          ? CartData.fromJson(json['data'])
          : null,  // Handle empty cart case
      notes: json['notes'] ?? [],
    );
  }
}

class CartData {
  List<CartItem> cartItems;
  int totalPrice;
  List<Product> products;

  CartData({
    required this.cartItems,
    required this.totalPrice,
    required this.products,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cartItems: json['cart_items'] != null
          ? List<CartItem>.from(
          json['cart_items'].map((x) => CartItem.fromJson(x)))
          : [],
      totalPrice: json['total_price'] ?? 0,
      products: json['products'] != null
          ? List<Product>.from(
          json['products'].map((x) => Product.fromJson(x)))
          : [],
    );
  }
}

class CartItem {
  int id;
  int cartId;
  int productId;
  int quantity;
  String createdAt;
  String updatedAt;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cart_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Product {
  int id;
  int storeId;
  int categoryId;
  String name;
  String description;
  String type;
  String price;
  int quantity;
  String createdAt;
  String updatedAt;
  int offer;
  dynamic saleAmount;
  List<ProductImage> productImages;

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      storeId: json['store_id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      offer: json['offer'],
      saleAmount: json['sale_amount'],
      productImages: (json['product_images'] as List<dynamic>)
          .map((image) => ProductImage.fromJson(image))
          .toList(),
    );
  }
}

class ProductImage {
  int id;
  int productId;
  String image;
  dynamic notes;
  String createdAt;
  String updatedAt;

  ProductImage({
    required this.id,
    required this.productId,
    required this.image,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['product_id'],
      image: json['image'],
      notes: json['notes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
