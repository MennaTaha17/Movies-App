import 'package:flutter/material.dart';
import 'package:movies/screens/auth/forget_password_screen.dart';
import 'package:movies/common/Theme/theme.dart';
import 'package:movies/screens/auth/login_screen.dart';
import 'package:movies/screens/auth/sign_up_screen.dart';
import 'package:movies/screens/update%20profile/update_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      SignUpScreen.routeName:(_) => SignUpScreen(),
      UpdateProfile.routeName:(_) => UpdateProfile(),
    },
      initialRoute: UpdateProfile.routeName,
    );
  }
}

