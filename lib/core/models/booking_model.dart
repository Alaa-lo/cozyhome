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

  final Apartment? apartment;

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
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),

      renterId: int.tryParse(json['renter_id'].toString()) ?? 0,

      apartmentId: int.tryParse(json['apartment_id'].toString()) ?? 0,

      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),

      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,

      status: json['status'] ?? 'pending',

      numberOfPersons: int.tryParse(json['number_of_persons'].toString()) ?? 1,

      notes: json['notes'],

      apartment: json['apartment'] != null
          ? Apartment.fromJson(json['apartment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'renter_id': renterId,
      'apartment_id': apartmentId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_price': totalPrice,
      'status': status,
      'number_of_persons': numberOfPersons,
      'notes': notes,
    };
  }
}
