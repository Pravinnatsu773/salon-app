// To parse this JSON data, do
//
//     final storeCategory = storeCategoryFromJson(jsonString);

import 'dart:convert';

List<StoreCategory> storeCategoryFromJson(dynamic data) =>
    List<StoreCategory>.from(data.map((x) => StoreCategory.fromJson(x)));

String storeCategoryToJson(List<StoreCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreCategory {
  String id;
  String text;

  StoreCategory({
    required this.id,
    required this.text,
  });

  factory StoreCategory.fromJson(Map<String, dynamic> json) => StoreCategory(
        id: json["_id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
      };
}
