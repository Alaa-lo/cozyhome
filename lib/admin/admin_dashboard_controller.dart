import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/admin/pending_model.dart';

class AdminDashboardController {
  // ================================
  // 1) جلب الحسابات المعلقة
  // ================================
  Future<List<PendingUser>> getPendingUsers() async {
    final prefs = await SharedPreferences.getInstance();

    // ⭐ قراءة قائمة الإيميلات المعلقة
    List<String> pendingEmails = prefs.getStringList("pendingRequests") ?? [];

    List<PendingUser> users = [];

    for (String email in pendingEmails) {
      // ⭐ جلب بيانات المستخدم من SharedPreferences
      String firstName = prefs.getString("firstName") ?? "Unknown";
      String lastName = prefs.getString("lastName") ?? "Unknown";
      String birthDate = prefs.getString("birthDate") ?? "Unknown";
      String frontImage = prefs.getString("profileImagePath") ?? "";
      String backImage = prefs.getString("idImagePath") ?? "";

      // ⭐ إنشاء مستخدم مع البيانات الحقيقية
      users.add(
        PendingUser(
          id: email.hashCode, // ID مؤقت
          firstName: firstName,
          lastName: lastName,
          birthDate: birthDate,
          frontImage: frontImage,
          backImage: backImage,
          email: email,
        ),
      );
    }

    return users;
  }

  // ================================
  // 2) الموافقة على مستخدم
  // ================================
  Future<void> approveUser(String email) async {
    final prefs = await SharedPreferences.getInstance();

    // ⭐ إزالة المستخدم من قائمة الطلبات
    List<String> pending = prefs.getStringList("pendingRequests") ?? [];
    pending.remove(email);
    await prefs.setStringList("pendingRequests", pending);

    // ⭐ وضع موافقة الأدمن
    await prefs.setBool("adminApproved", true);

    print("Approved user: $email");

    // ================================
    // 🔗 هنا تربطي مع الباك اند لاحقًا:
    // await ApiService.approveUser(email);
    // ================================
  }

  // ================================
  // 3) رفض مستخدم
  // ================================
  Future<void> rejectUser(String email) async {
    final prefs = await SharedPreferences.getInstance();

    // ⭐ إزالة المستخدم من قائمة الطلبات
    List<String> pending = prefs.getStringList("pendingRequests") ?? [];
    pending.remove(email);
    await prefs.setStringList("pendingRequests", pending);

    print("Rejected user: $email");

    // ================================
    // 🔗 هنا تربطي مع الباك اند لاحقًا:
    // await ApiService.rejectUser(email);
    // ================================
  }
}
