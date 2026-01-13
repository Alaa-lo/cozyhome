import 'package:cozy_home_1/core/models/apartment_model.dart';

class Booking {
  final int? id;
  final int apartmentId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int numberOfPersons;
  final String? notes;
  final double? totalPrice;
  final Apartment? apartment;

  Booking({
    this.id,
    required this.apartmentId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.numberOfPersons,
    this.notes,
    this.totalPrice,
    this.apartment,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      apartmentId: json['apartment_id'] ?? 0,
      startDate: DateTime.parse(
        json['start_date'] ?? DateTime.now().toIso8601String(),
      ),
      endDate: DateTime.parse(
        json['end_date'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? 'pending',
      numberOfPersons: json['number_of_persons'] ?? 1,
      notes: json['notes'],
      totalPrice: (json['total_price'] != null)
          ? double.tryParse(json['total_price'].toString())
          : null,
      apartment: json['apartment'] != null
          ? Apartment.fromJson(json['apartment'])
          : null,
    );
  }
}
