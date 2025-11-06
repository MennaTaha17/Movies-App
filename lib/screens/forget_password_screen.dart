import 'package:flutter/material.dart';
import 'package:movies/common/app_colors.dart';
import 'package:movies/otp_verfication.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgetPasswordScreen';

  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          Navigator.pushNamed(context, OtpVerification.routeName);
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
