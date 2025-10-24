import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/movies/common/custom_text_filed.dart';
import 'package:movies/common/Widget/custom_main_button.dart';
import 'package:movies/services/auth_services.dart';

import '../../common/widget/custom_text_filed.dart' show CustomTextFiled;
import '../common/widget/custom_main_button.dart' show CustomMainButton; // استخدام المسار المصحح

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgetPasswordScreen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final AuthServices _authServices = AuthServices(); // إنشاء مثيل للخدمة

  bool _isLoading = false;
  String? _message;
  Color _messageColor = Colors.red;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _message = null;
    });

    final String email = emailController.text.trim();

    try {
      final String? error = await _authServices.sendPasswordResetEmail(email);

      if (error == null) {
        _messageColor = Colors.green;
        _message = "A password reset link has been sent to your email address.";
      } else {
        _messageColor = Colors.red;
        // يمكنك تعديل الرسائل بناءً على أكواد Firebase:
        if (error == 'user-not-found') {
          _message = "No user found for that email.";
        } else {
          _message = "An error occurred: $error";
        }
      }
    } catch (e) {
      _messageColor = Colors.red;
      _message = "Unexpected error. Please check your connection.";
      print("Reset Password Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Enter your email address to receive a password reset link.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

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
                const SizedBox(height: 30),

                if (_message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      _message!,
                      style: TextStyle(color: _messageColor),
                      textAlign: TextAlign.center,
                    ),
                  ),

                widget,
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // العودة لشاشة تسجيل الدخول
                  },
                  child: const Text('Back to Login', style: TextStyle(color: AppColors.yellowColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}