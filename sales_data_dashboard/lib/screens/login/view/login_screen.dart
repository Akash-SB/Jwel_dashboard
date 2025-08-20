import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'package:sales_data_dashboard/screens/login/store/login_screen_store.dart';
import 'package:sales_data_dashboard/screens/login/view/login_button.dart';
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
        padding: EdgeInsets.symmetric(
          vertical: 50.dp,
          horizontal: 30.dp,
        ),
        child: Container(
          padding: EdgeInsets.all(16.dp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                16.dp,
              ),
            ),
          ),
          child: Row(
            children: [
              // Left Carousel
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.dp),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/login_promo_1.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: const Color(0xFF1E3A8A).withOpacity(0.5),
                      ),
                      // Centered icon and text
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon (replace with your desired icon)
                            Image.asset(
                              'assets/icons/apps_icon.png',
                              width: 36.dp,
                              height: 36.dp,
                              color: Colors.white,
                            ),
                            SizedBox(height: 24.dp),
                            Text(
                              'Streamline Your Gem Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.dp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.dp),
                            Text(
                              'An intelligent platform for efficient inventory and sales tracking',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.dp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right Login Form
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.dp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/diamond_icon.png',
                            width: 30.dp,
                            height: 30.dp,
                          ),
                          SizedBox(
                            width: 8.dp,
                          ),
                          Text(
                            "Sahajanand Gems",
                            style: TextStyle(
                                fontSize: 28.dp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF312E81)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.dp),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 24.dp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.dp),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "Sign in your account",
                          style: TextStyle(
                            fontSize: 14.dp,
                            fontWeight: FontWeight.w700,
                            color: const Color(
                              0xFF4B5563,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.dp),
                      Observer(builder: (context) {
                        return LoginCustomTextfield.email(
                          onChanged: loginStore.setEmail,
                          controller: emailController,
                          validator: (value) => value == null || value.isEmpty
                              ? "Username cannot be empty"
                              : null,
                        );
                      }),
                      SizedBox(height: 24.dp),
                      Observer(builder: (context) {
                        return LoginCustomTextfield.password(
                          onChanged: loginStore.setPassword,
                          controller: passwordController,
                          validator: (value) => value == null || value.isEmpty
                              ? "Password cannot be empty"
                              : null,
                        );
                      }),
                      SizedBox(height: 68.dp),
                      Observer(builder: (context) {
                        return AbsorbPointer(
                          absorbing: !loginStore.isValid,
                          child: Opacity(
                            opacity: loginStore.isValid ? 1 : 0.5,
                            child: LoginButton(
                              label: 'Login',
                              onPressed: () {
                                final success = loginStore.login();
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
