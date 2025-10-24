import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

import 'package:movies/model/user_model.dart';
import 'package:movies/services/auth_services.dart';

import '../../common/widget/custom_text_filed.dart';
import '../common/widget/custom_main_button.dart';
import '../home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    UserModel user = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneNumberController.text.trim(),
    );

    try {
      UserModel? result = await AuthServices.signUpWithEmail(
          user, passwordController.text.trim());

      if (result != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = "حدث خطأ أثناء التسجيل. حاول مرة أخرى.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "حدث خطأ غير متوقع. حاول مرة أخرى.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Register",
                  style: TextStyle(
                    color: AppColors.yellowColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFiled(
                  icon: Icons.person,
                  text: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Name is required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFiled(
                  icon: Icons.email,
                  text: 'Email',
                  controller: emailController,
                  validator: (value) {
                    bool validateEmail() => RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value ?? '');
                    if (value == null || value.isEmpty) return 'Email is required';
                    if (!validateEmail()) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFiled(
                  icon: Icons.lock,
                  text: 'Password',
                  controller: passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    if (value.length < 5) return 'Password must be at least 5 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFiled(
                  icon: Icons.lock,
                  text: 'Confirm Password',
                  controller: confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm Password is required';
                    if (value != passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFiled(
                  icon: Icons.phone,
                  text: 'Phone Number',
                  controller: phoneNumberController,
                  validator: (value) {
                    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,12}$');
                    if (value == null || value.isEmpty) return 'Phone Number is required';
                    if (!phoneRegex.hasMatch(value)) return 'Enter a valid phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : CustomMainButton(
                  text: 'Create Account',
                  color: AppColors.yellowColor,
                  textColor: Colors.black,
                  onPressed: _handleSignUp,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

