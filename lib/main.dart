import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/common/app_colors.dart';
import 'package:movies/otp_verfication.dart';
import 'package:movies/screens/forget_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      routes: {
        ForgetPasswordScreen.routeName: (_)=> ForgetPasswordScreen(),
        OtpVerification.routeName:(_)=> OtpVerification(),
      },
      initialRoute: ForgetPasswordScreen.routeName,
    );
  }
}

