import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'package:sales_data_dashboard/screens/login/store/login_screen_store.dart';
import 'package:sales_data_dashboard/screens/login/view/login_button.dart';
import 'package:sales_data_dashboard/screens/login/view/login_carousal_widget.dart';
import 'package:sales_data_dashboard/screens/login/view/login_custom_textfield.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  late final LoginScreenStore loginStore;

  @override
  void initState() {
    super.initState();
    // Register only if not already
    if (!getIt.isRegistered<LoginScreenStore>()) {
      getIt.registerFactory<LoginScreenStore>(() => LoginScreenStore());
    }

    loginStore = getIt<LoginScreenStore>();

    // Singleton: Single instance created immediately
    // if (!getIt.isRegistered<LoginScreenStore>(instanceName: 'singleton')) {
    //   getIt.registerSingleton<LoginScreenStore>(
    //     LoginScreenStore(),
    //     instanceName: 'singleton',
    //   );
    // }

    // For singleton (always same instance)
// final loginStoreSingleton = getIt<LoginScreenStore>(instanceName: 'singleton');

    // Lazy Singleton: Single instance created on first access
    // if (!getIt.isRegistered<LoginScreenStore>(instanceName: 'lazy')) {
    //   getIt.registerLazySingleton<LoginScreenStore>(
    //     () => LoginScreenStore(),
    //     instanceName: 'lazy',
    //   );
    // }

// For lazy singleton (first time created, then reused)
// final loginStoreLazy = getIt<LoginScreenStore>(instanceName: 'lazy');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // unregister factory store
    // if (getIt.isRegistered<LoginScreenStore>()) {
    //   getIt.unregister<LoginScreenStore>();
    // }

    //If you use lazySingleton and want to clear the instance but keep it registered, use:
    // getIt.resetLazySingleton<LoginScreenStore>();
    //This keeps the registration but resets the instance so that a new one is created on next use.

    super.dispose();
  }

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome Back\nto Real Nest!",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        "Sign in your account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Observer(builder: (context) {
                        return LoginCustomTextfield(
                          hint: 'UserName',
                          icon: Icons.email,
                          onChanged: loginStore.setEmail,
                          label: 'Enter Your UserName',
                          controller: emailController,
                          validator: (value) => value == null || value.isEmpty
                              ? "Username cannot be empty"
                              : null,
                        );
                      }),
                      const SizedBox(height: 28),
                      Observer(builder: (context) {
                        return LoginCustomTextfield(
                          hint: 'Password',
                          onChanged: loginStore.setPassword,
                          icon: Icons.lock,
                          obscure: true,
                          controller: passwordController,
                          label: 'Enter Your Password',
                          validator: (value) => value == null || value.isEmpty
                              ? "Password cannot be empty"
                              : null,
                        );
                      }),
                      const SizedBox(height: 56),
                      Observer(builder: (context) {
                        return AbsorbPointer(
                          absorbing: !loginStore.isValid,
                          child: Opacity(
                            opacity: loginStore.isValid ? 1 : 0.5,
                            child: LoginButton(
                              label: 'Login',
                              onPressed: () async {
                                final success = await loginStore.login();
                                if (success &&
                                    loginStore.email == 'Admin' &&
                                    loginStore.password == 'Admin@123') {
                                  if (!mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const IndexScreen(),
                                    ),
                                  );
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      dismissDirection: DismissDirection.down,
                                      content: Text(
                                        ' Please Enter Valid Credentials',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }),
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
