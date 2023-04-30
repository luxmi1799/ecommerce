// To parse this JSON data, do
//
//     final ecommerce = ecommerceFromJson(jsonString);

import 'dart:convert';

Products_DB ecommerceFromJson(String str) =>
    Products_DB.fromJson(json.decode(str));

String ecommerceToJson(Products_DB data) => json.encode(data.toMap());

class Products_DB {
  int? id;
  String? title;
  String? price;
  String? featuredImage;

  Products_DB({
    this.id,
    required this.title,
    required this.price,
    required this.featuredImage,
  });

  factory Products_DB.fromJson(Map<String, dynamic> json) => Products_DB(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        featuredImage: json["featured_image"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "price": price,
      "featured_image": featuredImage,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}
