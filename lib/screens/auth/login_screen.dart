

import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_text_filed.dart';
import 'package:movies/network/auth_services.dart';
import 'package:movies/screens/movie_details/movie_list_screen.dart';
import 'package:movies/screens/update profile/update_profile.dart';
import 'package:movies/tabs/profile_tab/profile_tab.dart';

import '../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 60),
                 Assets.asstes.images.png.videoImage.image(),
                  const SizedBox(height: 50),

                  // Email
                  CustomTextFiled(
                    controller: _emailController,
                    icon: Icons.email_rounded,
                    text: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  // Password
                  CustomTextFiled(
                    controller: _passwordController,
                    icon: Icons.lock,
                    text: 'Password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {

                        if(!_globalKey.currentState!.validate()) return;

                        setState(() { loading = true; });

                        final user = await AuthServices.LogInWithEmail(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        setState(() { loading = false; });

                        if(user == null){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid email or password")),
                          );
                          return;
                        }

                        Navigator.pushReplacementNamed(context, MovieListScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
