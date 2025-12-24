import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import 'package:cozy_home_1/features/auth/screens/registerscreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logos/cozyhomelogo.png',
                width: 300,
                height: 150,
              ),

              const SizedBox(height: 32),

              // Email Field
              TextField(
                controller: controller.emailController,
                cursorColor: Color(0xFF375534),
                decoration: InputDecoration(
                  labelText: 'Email / Phone',
                  hintText: 'Enter your email or phone',
                  hintStyle: const TextStyle(color: Colors.grey),
                  floatingLabelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF375534),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF375534)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF375534),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                cursorColor: Color(0xFF375534),
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  floatingLabelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: Color(0xFF375534),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF375534)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF375534),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Add forgot password logic
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.black, // اللون الأسود
                      fontSize: 14,
                      decoration: TextDecoration.underline, // خط تحت النص
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24), // نزلت الأزرار لتحت
              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => controller.login(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF375534),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFF375534)),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFF375534)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
