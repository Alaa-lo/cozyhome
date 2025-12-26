import 'package:flutter/material.dart';
import 'admin_dashboard_controller.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  final AdminDashboardController controller = AdminDashboardController();

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
                future: controller.getPendingUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final users = snapshot.data!;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return _userCard(
                        name: user["name"],
                        email: user["email"],
                        type: user["type"],
                        onApprove: () => controller.approveUser(user["id"]),
                        onReject: () => controller.rejectUser(user["id"]),
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
    required String name,
    required String email,
    required String type,
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
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234E36),
                ),
              ),
              const SizedBox(height: 6),
              Text(email, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 6),
              Text(
                "Type: $type",
                style: const TextStyle(color: Colors.black87),
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
}
