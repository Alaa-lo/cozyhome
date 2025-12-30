class Booking {
  final int? id;
  final int apartmentId;
  final String startDate;
  final String endDate;
  final String status;
  final int numberOfPersons;
  final String? notes;
  final double? totalPrice;

  Booking({
    this.id,
    required this.apartmentId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.numberOfPersons,
    this.notes,
    this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      apartmentId: json['apartment_id'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? 'pending',
      numberOfPersons: json['number_of_persons'] ?? 1,
      notes: json['notes'],
      totalPrice: (json['total_price'] != null)
          ? double.tryParse(json['total_price'].toString())
          : null,
    );
  }
}
