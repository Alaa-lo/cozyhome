class PendingUser {
  final int id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String frontImage;
  final String backImage;
  final String email; // ⭐ أضفنا الإيميل

  PendingUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.frontImage,
    required this.backImage,
    required this.email, // ⭐ خزّناه
  });

  // لتحويل JSON إلى PendingUser
  factory PendingUser.fromJson(Map<String, dynamic> json) {
    return PendingUser(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      birthDate: json["birthDate"],
      frontImage: json["frontImage"],
      backImage: json["backImage"],
      email: json["email"] ?? "", // ⭐ نرجّع الإيميل من JSON
    );
  }
}
