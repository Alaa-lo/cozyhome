class AdminDashboardController {
  // جلب الحسابات المعلقة (مؤقتًا بيانات ثابتة)
  Future<List<Map<String, dynamic>>> getPendingUsers() async {
    await Future.delayed(const Duration(seconds: 1)); // محاكاة API

    return [
      {
        "id": 1,
        "name": "Alaa Ahmad",
        "email": "alaa@example.com",
        "type": "Renter",
      },
      {
        "id": 2,
        "name": "Omar Khaled",
        "email": "omar@example.com",
        "type": "Owner",
      },
    ];
  }

  // الموافقة على مستخدم
  Future<void> approveUser(int userId) async {
    print("Approved user: $userId");
    // هون لاحقًا بتحط API call
  }

  // رفض مستخدم
  Future<void> rejectUser(int userId) async {
    print("Rejected user: $userId");
    // هون لاحقًا بتحط API call
  }
}
