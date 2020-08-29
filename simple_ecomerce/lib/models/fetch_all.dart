// To parse this JSON data, do
//
//     final fetchAll = fetchAllFromJson(jsonString);

import 'dart:convert';

FetchAll fetchAllFromJson(String str) => FetchAll.fromJson(json.decode(str));

String fetchAllToJson(FetchAll data) => json.encode(data.toJson());

class FetchAll {
  FetchAll({
    this.value,
    this.message,
    this.categories,
    this.products,
  });

  final int value;
  final String message;
  final List<Category> categories;
  final List<Product> products;

  factory FetchAll.fromJson(Map<String, dynamic> json) => FetchAll(
    value: json["value"],
    message: json["message"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
  });

  final String categoryId;
  final String categoryName;
  final String categoryImage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryNameValues.reverse[categoryName],
    "category_image": categoryImage,
  };
}

enum CategoryName { LAPTOP, CELANA, BAJU, SEPATU }

final categoryNameValues = EnumValues({
  "Baju": CategoryName.BAJU,
  "Celana": CategoryName.CELANA,
  "Laptop": CategoryName.LAPTOP,
  "Sepatu": CategoryName.SEPATU
});

class Product {
  Product({
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productImage,
    this.productCategory,
    this.productCategoryImage,
  });

  final String productId;
  final String productName;
  final String productPrice;
  final String productDescription;
  final String productImage;
  final String productCategory;
  final String productCategoryImage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDescription: json["product_description"],
    productImage: json["product_image"],
    productCategory: json["product_category"],
    productCategoryImage: json["product_category_image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_description": productDescription,
    "product_image": productImage,
    "product_category": productCategory,
    "product_category_image": productCategoryImage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}