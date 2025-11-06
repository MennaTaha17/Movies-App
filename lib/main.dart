import 'package:flutter/material.dart';
import 'package:movies/otp_verfication.dart';
import 'package:movies/screens/forget_password_screen.dart';
import 'package:movies/common/Theme/theme.dart';
import 'package:movies/screens/auth/login_screen.dart';
import 'package:movies/screens/update%20profile/update_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      title: 'Movies App',
      routes: {
        ForgetPasswordScreen.routeName: (_)=> ForgetPasswordScreen(),
        OtpVerification.routeName:(_)=> OtpVerification(),
        LoginScreen.routeName:(_)=>LoginScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}

