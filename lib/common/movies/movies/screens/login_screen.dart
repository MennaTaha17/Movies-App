import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

import '../../../../services/auth_services.dart';
import '../../common/widget/custom_text_filed.dart';
import '../home_screen.dart';
import 'forget_password_screen.dart'; // تم تصحيح: تغيير الاسم إلى auth_service.dart وإزالة /movies/

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ملاحظة: تأكد من وجود صورة 'video_image.png' في المسار assets/images/png/
                  Image.asset('assets/images/png/video_image.png'),
                  const SizedBox(height: 50),
                  CustomTextFiled(
                    controller: emailController,
                    icon: Icons.email_rounded,
                    text: 'Email',
                    validator: (value) {
                      bool validateEmail() => RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value ?? '');
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!validateEmail()) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 22),
                  CustomTextFiled(
                    controller: passwordController,
                    icon: Icons.lock,
                    text: 'Password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 5) {
                        return 'Password must be at least 5 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 17.18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.yellowColor,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      child: const Text("Forgot Password?"),
                    ),
                  ),

                  const SizedBox(height: 12),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                        if (!_formKey.currentState!.validate()) return;

                        setState(() {
                          _isLoading = true;
                          _errorMessage = null;
                        });

                        try {
                          // هنا يتم استدعاء AuthService.logInWithEmail()
                          final user =
                          await AuthServices.logInWithEmail(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          if (user != null) {
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          } else {
                            setState(() {
                              _errorMessage =
                              "Invalid email or password.";
                            });
                          }
                        } catch (e) {
                          setState(() {
                            _errorMessage =
                            "Unexpected error occurred. Please try again.";
                            // يمكنك طباعة الخطأ الكامل في الكونسول للمطور
                            print("Login Error: $e");
                          });
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        _isLoading ? "Loading..." : "Login",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      TextButton(
                        // يجب أن ينقلك هذا الزر إلى شاشة التسجيل
                        onPressed: () {
                          // Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.yellowColor,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("Create account"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 60, height: 1, color: AppColors.yellowColor),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColors.yellowColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(width: 60, height: 1, color: AppColors.yellowColor),
                    ],
                  ),

                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        print("Login with Google clicked");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ملاحظة: تأكد من وجود صورة 'google_icon.png' في المسار
                          Image.asset(
                            'assets/images/png/google_icon.png',
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Login with Google',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: AppColors.yellowColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ملاحظة: تأكد من وجود صورة 'usatate_flag.png' في المسار
                        Image.asset(
                          'assets/images/png/usatate_flag.png',
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(width: 15),
                        // ملاحظة: تأكد من وجود صورة 'egypt_flag.png' في المسار
                        Image.asset(
                          'assets/images/png/egypt_flag.png',
                          width: 26,
                          height: 26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}