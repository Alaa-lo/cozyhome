class Apartment {
  final int? id;
  final String title;
  final String description;
  final String city;
  final String province;
  final String? address; // اختياري
  final double pricePerNight;
  final List<String> images;
  final int? ownerId;
  final bool isFavorite;

  Apartment({
    this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.province,
    this.address,
    required this.pricePerNight,
    this.images = const [],
    this.ownerId,
    this.isFavorite = false,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      city: json['city'] ?? '',
      province: json['province'] ?? '',
      address: json['address'], // إذا موجود
      pricePerNight: (json['price_per_night'] != null)
          ? double.tryParse(json['price_per_night'].toString()) ?? 0.0
          : 0.0,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      ownerId: json['owner_id'],
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'city': city,
      'province': province,
      'address': address,
      'price_per_night': pricePerNight,
      'images': images,
    };
  }

  Apartment copyWith({
    int? id,
    String? title,
    String? description,
    String? city,
    String? province,
    String? address,
    double? pricePerNight,
    List<String>? images,
    int? ownerId,
    bool? isFavorite,
  }) {
    return Apartment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      city: city ?? this.city,
      province: province ?? this.province,
      address: address ?? this.address,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      images: images ?? this.images,
      ownerId: ownerId ?? this.ownerId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
