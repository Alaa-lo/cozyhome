import 'package:cozy_home_1/core/models/apartment_model.dart';

class Booking {
  final int id;
  final int renterId;
  final int apartmentId;

  final DateTime startDate;
  final DateTime endDate;

  final double totalPrice;
  final String status;
  final int numberOfPersons;
  final String? notes;

  final Apartment? apartment; // موجود فقط عند renter

  Booking({
    required this.id,
    required this.renterId,
    required this.apartmentId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    required this.numberOfPersons,
    this.notes,
    this.apartment,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      renterId: json['renter_id'] ?? 0,
      apartmentId: json['apartment_id'] ?? 0,

      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),

      // 🔥 التعديل المهم هنا
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,

      status: json['status'] ?? 'pending',
      numberOfPersons: json['number_of_persons'] ?? 1,
      notes: json['notes'],

      apartment: json['apartment'] != null
          ? Apartment.fromJson(json['apartment'])
          : null,
    );
  }
}
