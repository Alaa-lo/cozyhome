class ApartmentModel {
  String title;
  String governorate;
  String city;
  String address;
  double price;
  String priceType;
  List<String> images;

  ApartmentModel({
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
      "title": title,
      "governorate": governorate,
      "city": city,
      "address": address,
      "price": price,
      "priceType": priceType,
      "images": images,
    };
  }
}
