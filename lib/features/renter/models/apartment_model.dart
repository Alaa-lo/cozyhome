class Apartment {
  final String title; // اسم الشقة
  final String governorate; // المحافظة
  final String city; // المدينة
  final double price; // السعر
  final List<String> images; // صور الشقة (كاروسيل)

  Apartment({
    required this.title,
    required this.governorate,
    required this.city,
    required this.price,
    required this.images,
  });
}
