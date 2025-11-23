import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_text_filed.dart';
import 'package:movies/common/Widget/custom_main_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Email and Password are required";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // تسجيل دخول ناجح
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Wrong password provided.';
        } else {
          _errorMessage = e.message;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Unexpected error. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(19),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/png/video_image.png'),
              const SizedBox(height: 50),

              CustomTextFiled(
                icon: Icons.email_rounded,
                text: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 22),

              CustomTextFiled(
                icon: Icons.lock,
                text: 'Password',
                controller: passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 17),

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    print('Forget Password ?');
                  },
                  child: Text(
                    'Forget Password ?',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomMainButton(
                text: 'Login',
                color: Color(0xFFFFC107),
                textColor:Color(0xFF0E0E0E),
                onPressed: () {
                  print("Email entered: ${emailController.text.trim()}");
                  _handleLogin();
                },
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Have Account ? ",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signUpScreen');
                    },
                    child: Text(
                      "Create One",
                      style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
