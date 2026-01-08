class User {
  final int? id;
  final String fullname;
  final String phonenumber;
  final String role;
  final String? birthDate;
  final String? email;
  final String? profileImage;
  final String? idImage;
  final bool isApproved;

  User({
    this.id,
    required this.fullname,
    required this.phonenumber,
    required this.role,
    this.email,
    this.birthDate,
    this.profileImage,
    this.idImage,
    this.isApproved = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print("User.fromJson: Parsing JSON: $json");
    try {
      final userData = json.containsKey('user') ? json['user'] : json;

      String firstName = userData['first_name'] ?? '';
      String lastName = userData['last_name'] ?? '';

      final user = User(
        id: userData['id'],
        fullname: userData['fullname'] ?? "$firstName $lastName".trim(),
        phonenumber: userData['phonenumber'] ?? '',
        email: userData['email'],
        role: userData['role'] ?? 'renter',
        birthDate: userData['birth_date'],
        // ✅ تعديل أسماء الحقول لتطابق الباك إند
        profileImage: userData['photo_url'],
        idImage: userData['id_img_url'],
        isApproved: userData['status'] == 'approved',
      );
      print(
        "User.fromJson: Successfully parsed user: ${user.fullname}, role: ${user.role}, isApproved: ${user.isApproved}",
      );
      return user;
    } catch (e, stack) {
      print("User.fromJson ERROR: $e");
      print(stack);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'phonenumber': phonenumber,
      'email': email,
      'role': role,
      'birth_date': birthDate,
      // ✅ نفس أسماء الحقول يلي الباك إند بيرجعها
      'photo_url': profileImage,
      'id_img_url': idImage,
      'status': isApproved ? 'approved' : 'pending',
    };
  }
}
