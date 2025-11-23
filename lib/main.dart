import 'package:flutter/material.dart';
import 'package:movies/providers/watch_list_provider.dart';
import 'package:movies/screens/Spalsh%20Onboradang/onboardang.dart';
import 'package:movies/screens/Spalsh%20Onboradang/spalsh_screen.dart';
import 'package:movies/screens/main_layer.dart';
import 'package:movies/screens/auth/forget_password_screen.dart';
import 'package:movies/common/Theme/theme.dart';
import 'package:movies/screens/auth/login_screen.dart';
import 'package:movies/screens/auth/sign_up_screen.dart';
import 'package:movies/screens/movie_details/movie_details.dart';
import 'package:movies/screens/movie_details/movie_list_screen.dart';
import 'package:movies/screens/update%20profile/update_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/tabs/profile_tab/profile_tab.dart';
import 'package:provider/provider.dart';
import 'package:movies/providers/settings_provider.dart';
import 'network/home_movies_repo.dart';
import 'providers/home_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(MoviesRepo())..loadHomeData(),
        ),
        ChangeNotifierProvider(create: (_) => WatchListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      title: 'Movies App',
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        UpdateProfile.routeName: (_) => UpdateProfile(),
        ProfileTab.routeName: (_) => ProfileTab(),
        MainLayer.routeName: (_) => MainLayer(),
        MovieListScreen.routeName: (_) => MovieListScreen(),
        SplashScreen.routeName: (_) => SplashScreen(),
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetails.routeName) {
          final movieId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => MovieDetails(movieId: movieId),
          );
        }
        return null;
      },
    );
  }
}