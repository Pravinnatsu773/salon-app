// To parse this JSON data, do
//
//     final serviceTypesModel = serviceTypesModelFromJson(jsonString);

import 'dart:convert';

List<ServiceTypesModel> serviceTypesModelFromJson(dynamic data) =>
    List<ServiceTypesModel>.from(
        data.map((x) => ServiceTypesModel.fromJson(x)));

String serviceTypesModelToJson(List<ServiceTypesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceTypesModel {
  bool? offer;
  String offerValue;
  List<String> discription;
  String id;
  String category;
  ServiceType serviceType;
  String title;
  int price;
  double rating;
  int ratingCount;
  bool? active;
  SellingTag sellingTag;
  DateTime createdAt;
  DateTime updatedAt;
  int? discountedPrice;

  ServiceTypesModel({
    required this.offer,
    required this.offerValue,
    required this.discription,
    required this.id,
    required this.category,
    required this.serviceType,
    required this.title,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.active,
    required this.sellingTag,
    required this.createdAt,
    required this.updatedAt,
    this.discountedPrice,
  });

  factory ServiceTypesModel.fromJson(Map<String, dynamic> json) =>
      ServiceTypesModel(
        offer: json["offer"],
        offerValue: json["offerValue"],
        discription: List<String>.from(json["discription"].map((x) => x)),
        id: json["_id"],
        category: json["category"],
        serviceType: serviceTypeValues.map[json["serviceType"]]!,
        title: json["title"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        active: json["active"],
        sellingTag: sellingTagValues.map[json["sellingTag"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        discountedPrice: json["discountedPrice"],
      );

  Map<String, dynamic> toJson() => {
        "offer": offer,
        "offerValue": offerValue,
        "discription": List<dynamic>.from(discription.map((x) => x)),
        "_id": id,
        "category": category,
        "serviceType": serviceTypeValues.reverse[serviceType],
        "title": title,
        "price": price,
        "rating": rating,
        "ratingCount": ratingCount,
        "active": active,
        "sellingTag": sellingTagValues.reverse[sellingTag],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "discountedPrice": discountedPrice,
      };
}

enum SellingTag { BEST_SELLER, MUST_TRY, TRENDING }

final sellingTagValues = EnumValues({
  "BEST_SELLER": SellingTag.BEST_SELLER,
  "MUST_TRY": SellingTag.MUST_TRY,
  "TRENDING": SellingTag.TRENDING
});

enum ServiceType { NEW_LAUNCH, NEW_LAUUCH, TOP_SELLING }

final serviceTypeValues = EnumValues({
  "New Launch": ServiceType.NEW_LAUNCH,
  "New Lauuch": ServiceType.NEW_LAUUCH,
  "Top Selling": ServiceType.TOP_SELLING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
