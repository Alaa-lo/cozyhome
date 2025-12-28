import 'dart:io';
import 'package:cozy_home_1/admin/pending_model.dart';
import 'package:flutter/material.dart';
import 'admin_dashboard_controller.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminDashboardController controller = AdminDashboardController();

  late Future<List<PendingUser>> futureUsers;

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
              child: FutureBuilder(
                future: futureUsers,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final users = snapshot.data!;

                  if (users.isEmpty) {
                    return const Center(
                      child: Text(
                        "No pending accounts",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return _userCard(
                        user: user,
                        onApprove: () async {
                          await controller.approveUser(user.email);
                          refresh();
                        },
                        onReject: () async {
                          await controller.rejectUser(user.email);
                          refresh();
                        },
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
    required PendingUser user,
    required VoidCallback onApprove,
    required VoidCallback onReject,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234E36),
                ),
              ),
              const SizedBox(height: 6),

              Text(
                "Birth Date: ${user.birthDate}",
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  _imageBox(user.frontImage),
                  const SizedBox(width: 10),
                  _imageBox(user.backImage),
                ],
              ),
            ],
          ),

          // أزرار الموافقة والرفض
          Row(
            children: [
              OutlinedButton(
                onPressed: onReject,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF234E36), width: 2),
                ),
                child: const Text(
                  "Reject",
                  style: TextStyle(color: Color(0xFF234E36)),
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: onApprove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF234E36),
                ),
                child: const Text(
                  "Approve",
                  style: TextStyle(color: Color(0xFFEBEADA)),
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

    return Image.file(File(path), width: 60, height: 60, fit: BoxFit.cover);
  }
}
