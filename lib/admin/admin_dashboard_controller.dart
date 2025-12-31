import 'package:cozy_home_1/features/auth/models/user.dart';
import 'admin_service.dart';

class AdminDashboardController {
  final AdminService _adminService = AdminService();

  Future<List<User>> getPendingUsers() async {
    return await _adminService.getPendingUsers();
  }

  Future<void> approveUser(int userId) async {
    await _adminService.approveUser(userId);
  }

  Future<void> rejectUser(int userId) async {
    // This method is not in the documentation, doing nothing
  }
}
