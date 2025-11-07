import 'package:flutter/material.dart';
import 'package:movies/screens/auth/otp_verfication.dart';
import 'package:movies/screens/auth/forget_password_screen.dart';
import 'package:movies/common/Theme/theme.dart';
import 'package:movies/screens/auth/login_screen.dart';
import 'package:movies/screens/auth/sign_up_screen.dart';
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
        LoginScreen.routeName:(_) => LoginScreen(),
      ForgetPasswordScreen.routeName:(_) => ForgetPasswordScreen(),
      OtpVerification.routeName:(_) => OtpVerification(),
      SignUpScreen.routeName:(_) => SignUpScreen(),
    },
      initialRoute: SignUpScreen.routeName,
    );
  }
}

