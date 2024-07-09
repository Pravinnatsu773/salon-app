List<ServiceTypesModel> serviceTypesModelFromJson(dynamic data) {
  print(data);
  return List<ServiceTypesModel>.from(
      data.map((x) => ServiceTypesModel.fromJson(x)));
}

class ServiceTypesModel {
  List<Category> category;
  List<Category> serviceType;
  List<dynamic> serviceImage;
  bool offer;
  String offerValue;
  List<dynamic> description;
  String serviceDuration;
  List<String> brandsUsed;
  List<String> thingsToKnow;
  String id;
  String title;
  int price;
  double rating;
  int ratingCount;
  bool active;
  String sellingTag;
  List<HowItWork> howItWorks;
  DateTime createdAt;
  DateTime updatedAt;
  int? discountedPrice;

  ServiceTypesModel({
    required this.category,
    required this.serviceType,
    required this.serviceImage,
    required this.offer,
    required this.offerValue,
    required this.description,
    required this.serviceDuration,
    required this.brandsUsed,
    required this.thingsToKnow,
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.active,
    required this.sellingTag,
    required this.howItWorks,
    required this.createdAt,
    required this.updatedAt,
    this.discountedPrice,
  });

  factory ServiceTypesModel.fromJson(Map<String, dynamic> json) =>
      ServiceTypesModel(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        serviceType: List<Category>.from(
            json["serviceType"].map((x) => Category.fromJson(x))),
        serviceImage: List<dynamic>.from(json["serviceImage"].map((x) => x)),
        offer: json["offer"],
        offerValue: json["offerValue"],
        description: List<dynamic>.from(json["description"].map((x) => x)),
        serviceDuration: json["serviceDuration"],
        brandsUsed: List<String>.from(json["brandsUsed"].map((x) => x)),
        thingsToKnow: List<String>.from(json["thingsToKnow"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        active: json["active"],
        sellingTag: json["sellingTag"],
        howItWorks: List<HowItWork>.from(
            json["howItWorks"].map((x) => HowItWork.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        discountedPrice: json["discountedPrice"],
      );
}

class Category {
  String id;

  String type;
  String text;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.type,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        type: json["type"],
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "text": text,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class HowItWork {
  String id;
  String point;
  String description;

  HowItWork({
    required this.id,
    required this.point,
    required this.description,
  });

  factory HowItWork.fromJson(Map<String, dynamic> json) => HowItWork(
        id: json["_id"],
        point: json["point"],
        description: json["description"],
      );
}
