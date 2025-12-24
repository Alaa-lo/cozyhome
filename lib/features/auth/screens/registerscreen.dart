import 'package:flutter/material.dart';
import '../controllers/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
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
                  "Create Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF234E36),
                  ),
                ),

                const SizedBox(height: 30),

                _buildField(
                  label: "Full Name",
                  icon: Icons.person_outline,
                  controller: controller.nameController,
                ),

                const SizedBox(height: 16),

                _buildField(
                  label: "Email / Phone",
                  icon: Icons.email_outlined,
                  controller: controller.emailController,
                ),

                const SizedBox(height: 16),

                _buildField(
                  label: "Password",
                  icon: Icons.lock_outline,
                  controller: controller.passwordController,
                  obscure: true,
                ),

                const SizedBox(height: 16),

                _buildField(
                  label: "Confirm Password",
                  icon: Icons.lock_outline,
                  controller: controller.confirmPasswordController,
                  obscure: true,
                ),

                const SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Select Account Type:",
                    style: TextStyle(fontSize: 16, color: Color(0xFF375534)),
                  ),
                ),

                Row(
                  children: [
                    Radio(
                      value: "renter",
                      groupValue: controller.accountType,
                      activeColor: const Color(0xFF234E36),
                      onChanged: (value) {
                        setState(() => controller.accountType = value!);
                      },
                    ),
                    const Text("Renter"),
                    const SizedBox(width: 20),
                    Radio(
                      value: "owner",
                      groupValue: controller.accountType,
                      activeColor: const Color(0xFF234E36),
                      onChanged: (value) {
                        setState(() => controller.accountType = value!);
                      },
                    ),
                    const Text("Owner"),
                  ],
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
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Already have an account? Login",
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
