class User {
  final int? id;
  final String fullname;
  final String phonenumber;
  final String role;
  final String? birthDate;
  final String? profileImage;
  final String? idImage;
  final bool isApproved;

  User({
    this.id,
    required this.fullname,
    required this.phonenumber,
    required this.role,
    this.birthDate,
    this.profileImage,
    this.idImage,
    this.isApproved = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      role: json['role'] ?? 'renter',
      birthDate: json['birth_date'],
      profileImage: json['profile_image'],
      idImage: json['id_image'],
      isApproved: json['is_approved'] == 1 || json['is_approved'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'phonenumber': phonenumber,
      'role': role,
      'birth_date': birthDate,
      'profile_image': profileImage,
      'id_image': idImage,
    };
  }
}
