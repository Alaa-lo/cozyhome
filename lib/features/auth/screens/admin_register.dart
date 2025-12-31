import 'package:flutter/material.dart';
import '../controllers/admin_register_controller.dart';
import 'admin_login.dart';

class AdminRegisterScreen extends StatefulWidget {
  const AdminRegisterScreen({super.key});

  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  late final AdminRegisterController controller;

  @override
  void initState() {
    super.initState();
    controller = AdminRegisterController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF375534)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logos/cozyhomelogo.png',
                  width: 260,
                  height: 140,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Admin Registration",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF234E36),
                  ),
                ),

                const SizedBox(height: 30),

                // First Name
                _buildField(
                  label: "First Name",
                  icon: Icons.person_outline,
                  controller: controller.firstNameController,
                ),

                const SizedBox(height: 16),

                // Last Name
                _buildField(
                  label: "Last Name",
                  icon: Icons.person_outline,
                  controller: controller.lastNameController,
                ),

                const SizedBox(height: 16),

                // Phone Number
                _buildField(
                  label: "Phone Number",
                  icon: Icons.phone_outlined,
                  controller: controller.phoneController,
                ),

                const SizedBox(height: 16),

                // Password
                _buildField(
                  label: "Password",
                  icon: Icons.lock_outline,
                  controller: controller.passwordController,
                  obscure: true,
                ),

                const SizedBox(height: 16),

                // Confirm Password
                _buildField(
                  label: "Confirm Password",
                  icon: Icons.lock_outline,
                  controller: controller.confirmPasswordController,
                  obscure: true,
                ),

                const SizedBox(height: 25),

                // Info text about admin account
                const Text(
                  "This account will be created as an Admin account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF375534),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF234E36),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => controller.signUp(context),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminLoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an admin account? Login",
                    style: TextStyle(
                      color: Color(0xFF234E36),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      cursorColor: const Color(0xFF375534),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF375534)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 115, 139, 126),
            width: 2,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: const Color(0xFF234E36)),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

