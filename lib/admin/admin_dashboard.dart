import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/auth/models/user.dart';
import 'admin_dashboard_controller.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminDashboardController controller = AdminDashboardController();
  late Future<List<User>> futureUsers;

  final Map<int, bool> _loadingApprove = {};
  final Map<int, bool> _loadingReject = {};

  @override
  void initState() {
    super.initState();
    futureUsers = controller.getPendingUsers();
  }

  void refresh() {
    setState(() {
      futureUsers = controller.getPendingUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(color: Color(0xFFEBEADA)),
        ),
        actions: [const SizedBox(width: 10)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pending Accounts",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF234E36),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No pending accounts",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    );
                  }

                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return _userCard(
                        user: user,
                        onApprove: () async {
                          if (user.id != null) {
                            setState(() => _loadingApprove[user.id!] = true);
                            final message = await controller.approveUser(
                              user.id!,
                            );
                            if (mounted) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                            }
                            setState(() => _loadingApprove[user.id!] = false);
                            refresh();
                          }
                        },
                        onReject: () async {
                          if (user.id != null) {
                            setState(() => _loadingReject[user.id!] = true);
                            final message = await controller.rejectUser(
                              user.id!,
                            );
                            if (mounted) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                            }
                            setState(() => _loadingReject[user.id!] = false);
                            refresh();
                          }
                        },
                        isLoadingApprove: _loadingApprove[user.id] ?? false,
                        isLoadingReject: _loadingReject[user.id] ?? false,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCard({
    required User user,
    required VoidCallback onApprove,
    required VoidCallback onReject,
    required bool isLoadingApprove,
    required bool isLoadingReject,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF234E36), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // معلومات المستخدم
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullname,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234E36),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Phone: ${user.phonenumber}",
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Text(
                "Birth Date: ${user.birthDate ?? 'N/A'}",
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  if (user.profileImage != null) _imageBox(user.profileImage!),
                  const SizedBox(width: 10),
                  if (user.idImage != null) _imageBox(user.idImage!),
                ],
              ),
            ],
          ),
          // أزرار الموافقة والرفض
          Row(
            children: [
              ElevatedButton(
                onPressed: isLoadingApprove ? null : onApprove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF234E36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoadingApprove
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFEBEADA),
                        ),
                      )
                    : const Text(
                        "Approve",
                        style: TextStyle(color: Color(0xFFEBEADA)),
                      ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: isLoadingReject ? null : onReject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoadingReject
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Reject",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageBox(String path) {
    if (path.isEmpty) {
      return Container(
        width: 60,
        height: 60,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported),
      );
    }
    if (path.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          path,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image),
            );
          },
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(path),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 60,
            height: 60,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image),
          );
        },
      ),
    );
  }
}
