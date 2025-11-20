import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/screens/auth/login_screen.dart';
import '../../common/Theme/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgetPasswordScreen';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          title: Center(
            child: Text(
              "Forget Password", // ToDo Localization
              style: TextStyle(
                color: AppColors.yellowColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Image.asset('asstes/images/png/Forgot password-bro 1.png'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    style: TextStyle(color: AppColors.whiteColor),
                    controller: emailController,
                    validator: (value) {
                      bool validateEmail() => RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value ?? '');
                      if (value == null || value!.isEmpty) {
                        return 'Email is required';
                      } else if (!validateEmail()) {
                        return 'invalid email';
                      }
                    },
                    cursorColor: AppColors.whiteColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.grayColor,

                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 15,
                        ),
                        child: Icon(
                          Icons.email,
                          color: AppColors.whiteColor,
                          size: 30,
                          weight: 30,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.grayColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.grayColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.redColor),
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 398,
                    height: 56,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: AppColors.yellowColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (_globalKey.currentState!.validate()) {
                          try {
                            var userDocs =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .where(
                                      'email',
                                      isEqualTo: emailController.text.trim(),
                                    )
                                    .get();
                            if (userDocs.docs.isEmpty) {
                              await Flushbar(
                                duration: Duration(seconds: 5),
                                title: "Error",
                                message:
                                    "This email is not registered. Please check and try again.",
                                backgroundColor: AppColors.redColor,
                              ).show(context);
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                    email: emailController.text.trim(),
                                  );
                              await Flushbar(
                                duration: Duration(seconds: 5),
                                title: "Success",
                                message:
                                    "A password reset link has been sent to your email.\n"
                                        " It may take a few minutes for the email to arrive, please check your inbox.",
                                backgroundColor: AppColors.greenColor,
                              ).show(context);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushNamed(
                                context,
                                LoginScreen.routeName,
                              );
                            }
                          } catch (e) {
                            print(e);
                            await Flushbar(
                              duration: Duration(seconds: 5),
                              title: "Error",
                              message:
                                  "This email is not registered. Please check and try again.",
                              backgroundColor: AppColors.redColor,
                            ).show(context);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Verify Email',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
