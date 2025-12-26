class ApartmentModel {
  String id;
  String title;
  String governorate;
  String city;
  String address;
  double price;
  String priceType;
  List<String> images;

  ApartmentModel({
    required this.id,
    required this.title,
    required this.governorate,
    required this.city,
    required this.address,
    required this.price,
    required this.priceType,
    required List<String> images,
  }) : images = images.length > 4 ? images.sublist(0, 4) : images;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "governorate": governorate,
      "city": city,
      "address": address,
      "price": price,
      "priceType": priceType,
      "images": images,
    };
  }

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      id: json["id"],
      title: json["title"],
      governorate: json["governorate"],
      city: json["city"],
      address: json["address"],
      price: (json["price"] as num).toDouble(),
      priceType: json["priceType"],
      images: List<String>.from(json["images"] ?? []),
    );
  }

  ApartmentModel copyWith({
    String? id,
    String? title,
    String? governorate,
    String? city,
    String? address,
    double? price,
    String? priceType,
    List<String>? images,
  }) {
    return ApartmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      address: address ?? this.address,
      price: price ?? this.price,
      priceType: priceType ?? this.priceType,
      images: images ?? this.images,
    );
  }
}
