import 'package:cozy_home_1/features/auth/models/user.dart';
import 'admin_service.dart';

class AdminDashboardController {
  final AdminService _adminService = AdminService();

  /// جلب المستخدمين بانتظار الموافقة
  Future<List<User>> getPendingUsers() async {
    return await _adminService.getPendingUsers();
  }

  /// الموافقة على مستخدم
  Future<bool> approveUser(int userId) async {
    return await _adminService.approveUser(userId);
  }

  /// رفض مستخدم
  Future<bool> rejectUser(int userId) async {
    return await _adminService.rejectUser(userId);
  }
}
