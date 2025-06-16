import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/login_screen/view/login_button.dart';
import 'package:sales_data_dashboard/screens/login_screen/view/login_carousal_widget.dart';
import 'package:sales_data_dashboard/screens/login_screen/view/login_custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        color: const Color(0xFFDBDBDB),
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
          child: Row(
            children: [
              // Left Carousel
              const Expanded(
                flex: 1,
                child: LoginCarousalWidget(
                  images: [
                    'assets/login_promo_1.jpg',
                    'assets/login_promo_1.jpg',
                    'assets/login_promo_1.jpg'
                  ], // replace with your image
                  titles: [
                    'Manage Properties Efficiently',
                    'Track Payments Easily',
                    'All in One Platform',
                  ],
                  subtitles: [
                    'Track rent payments, maintenance requests,\nand tenant communications in one place.',
                    'No more spreadsheets. Everything is auto-logged\nand organized by tenant and property.',
                    'Reduce manual work and focus on what matters\nwith smart automation and alerts.',
                  ],
                ),
              ),

              // Right Login Form
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome Back to Real Nest!",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Text("Sign in your account"),
                      const SizedBox(height: 24),
                      LoginCustomTextfield(
                        hint: 'Your Email',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),
                      LoginCustomTextfield(
                        hint: 'Password',
                        icon: Icons.lock,
                        obscure: true,
                        controller: passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (_) {}),
                              const Text("Remember Me"),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?")),
                        ],
                      ),
                      const SizedBox(height: 16),
                      LoginButton(label: 'Login', onPressed: () {}),
                      const SizedBox(height: 20),
                      const Center(child: Text("Instant Login")),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.g_mobiledata),
                            onPressed: () {},
                            label: const Text("Sign in with Google"),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.apple),
                            onPressed: () {},
                            label: const Text("Sign in with Apple"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Don't have an account? Register"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
