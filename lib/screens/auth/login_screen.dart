import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_text_filed.dart';
import 'package:movies/screens/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName ='/loginScreen';
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(19),
            child: Form(
              key: _globalKey,
              child: Column(
                // crossAxisAlignment:CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asstes/images/png/video_image.png'),
                  const SizedBox(height: 50),
                  CustomTextFiled(
                    icon:Icons.email_rounded,
                    text: 'Email',
                    validator:  (value) {
                      bool validateEmail() =>
                          RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value ?? '');
                      if (value == null || value!.isEmpty) {
                        return 'Email is required';
                      } else if (!validateEmail()) {
                        return 'invalid email';
                      }
                    },
                  ),
                  const SizedBox(height: 22),

                  CustomTextFiled(
                      icon:Icons.lock,
                      text: 'Password',
                      isPassword: true,
                    validator: (value) {
                      if(value == null || value!.isEmpty){
                        return 'Password is required';
                      }else if(value.length < 5){
                        return 'invalid Password';
                      }
                    },
                  ),

                  const SizedBox(height: 17.18),
                  Align(
                    alignment: Alignment.centerRight,
                    child:  TextButton(
                      onPressed: () {
                          Navigator.pushReplacementNamed(context, ForgetPasswordScreen.routeName);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.yellowColor,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      child: Text("Forget Password ?"),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: () {

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Login', style: TextStyle(fontSize: 20))],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have Account ? ",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.yellowColor,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Create account"),
                      ),

                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 1,
                        color: AppColors.yellowColor,
                      ),
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
                      Container(
                        width: 60,
                        height: 1,
                        color: AppColors.yellowColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asstes/images/png/google_icon.png',
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Login With Google',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),

//TO DO LOCALIZATION

              const SizedBox(height: 25),Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color:AppColors.yellowColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asstes/images/png/usatate_flag.png',
                    width: 26,
                    height: 26,
                  ),
                  SizedBox(width: 15),
                  Image.asset(
                    'asstes/images/png/egypt_flag.png',
                    width: 26,
                    height: 26,
                  ),
                ],
              ),
          ),


              const SizedBox(height: 25),


                ]),
            )
        )
      )
    )
    );
  }
}