// To parse this JSON data, do
//
//     final ecommerce = ecommerceFromJson(jsonString);

import 'dart:convert';

Products ecommerceFromJson(String str) => Products.fromJson(json.decode(str));

String ecommerceToJson(Products data) => json.encode(data.toJson());

class Products {
  int id;
  String slug;
  String title;
  String description;
  int price;
  String featuredImage;
  String status;
  DateTime createdAt;

  Products({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.price,
    required this.featuredImage,
    required this.status,
    required this.createdAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        featuredImage: json["featured_image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "description": description,
        "price": price,
        "featured_image": featuredImage,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
