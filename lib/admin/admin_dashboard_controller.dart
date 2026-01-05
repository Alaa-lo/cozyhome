import 'package:cozy_home_1/features/auth/models/user.dart';
import 'admin_service.dart';
import 'package:flutter/foundation.dart';

class AdminDashboardController {
  final AdminService _adminService = AdminService();

  /// جلب المستخدمين بانتظار الموافقة
  Future<List<User>> getPendingUsers() async {
    try {
      return await _adminService.getPendingUsers();
    } catch (e) {
      debugPrint("Error in getPendingUsers: $e");
      return [];
    }
  }

  /// الموافقة على مستخدم
  Future<String> approveUser(int userId) async {
    try {
      final success = await _adminService.approveUser(userId);
      return success ? "User approved successfully" : "Failed to approve user";
    } catch (e) {
      debugPrint("Error in approveUser: $e");
      return "Error approving user";
    }
  }

  /// رفض مستخدم
  Future<String> rejectUser(int userId) async {
    try {
      final success = await _adminService.rejectUser(userId);
      return success ? "User rejected successfully" : "Failed to reject user";
    } catch (e) {
      debugPrint("Error in rejectUser: $e");
      return "Error rejecting user";
    }
  }
}
