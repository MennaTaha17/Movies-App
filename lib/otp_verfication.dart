import 'package:flutter/material.dart';
import 'common/Theme/app_colors.dart';

class OtpVerification extends StatelessWidget {
  static const String routeName = '/otpVerification';
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: SingleChildScrollView(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asstes/images/png/Forgot password-bro 1.png'),
              Center(
                child: Text(
                  'OTP Verification',
                  style: TextStyle(
                    color: AppColors.yellowColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
              ),
              Text(
                'Enter The OTP sent to (email)',
                style: TextStyle(
                  color: AppColors.yellowColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                  List.generate(
                    4,
                    (index) => SizedBox(
                      width: 50,
                      child: TextField(
                        cursorColor: AppColors.whiteColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.whiteColor,fontSize: 20,fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.grayColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
              SizedBox(
                width: 300,
                height: 56,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.yellowColor,
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t you receive The OTP?',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Recent OTP',
                      style: TextStyle(color: AppColors.yellowColor),
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
