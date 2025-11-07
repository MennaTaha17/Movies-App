import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_text_filed.dart';
import 'package:movies/common/Widget/custom_main_button.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signUpScreen';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
        body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _globalKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.yellowColor,
                          size: 20,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: AppColors.yellowColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height:40 ,)
                    ],
                  ),
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Image.asset('asstes/images/png/avatar(3).png', width: 94, height: 94),

                        const SizedBox(width: 18),


                        Column(
                          children: [
                            Image.asset('asstes/images/png/avatar(1).png', width: 150, height: 150),
                          ],
                        ),

                        const SizedBox(width: 18),

                        Image.asset('asstes/images/png/avatar(2).png', width: 94, height: 94),
                        const SizedBox(height: 41),

              ],
                    ),
                   ),
                     const SizedBox(height: 20),


                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "Avatar",
                           style: TextStyle(
                             color: AppColors.whiteColor,
                             fontSize: 16,
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                       ],
                     ),

                     const SizedBox(height: 20),


                     Column(
                       children: [
                         CustomTextFiled(
                           icon: Icons.person,
                           text: 'Name',
                        fontSize: 16,
                        controller: nameController,
                        validator: (value) {
                             if (value == null || value.isEmpty){
                               return "Name is required";
                             }
                             return null;
                        },
                         ),
                         const SizedBox(height: 20),
                          CustomTextFiled(
                           icon: Icons.email,
                           text: 'Email',
                           fontSize: 16,
                           controller: emailController,
                           validator:  (value) {
                             bool validateEmail() => RegExp(
                               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                             ).hasMatch(value ?? '');
                             if (value == null || value.isEmpty) {
                               return 'Email is required';
                             } else if (!validateEmail()) {
                               return 'Invalid email';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 20),
                          CustomTextFiled(
                           icon: Icons.lock,
                           text: 'Password',
                           fontSize: 16,
                           controller: passwordController,
                           isPassword: true,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Password is required';
                             } else if (value.length < 5) {
                               return 'password must ba at least 5 characters';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 20),
                          CustomTextFiled(
                           icon: Icons.lock,
                           text: 'Confirm Password',
                           fontSize: 16,
                           controller: confirmPasswordController,
                           isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              } else if (value != passwordController.text) {
                                return 'password doesn\'t match';
                              }
                              return null;
                            },
                         ),
                         const SizedBox(height: 20),
                          CustomTextFiled(
                           icon: Icons.phone,
                           text: 'Phone Number',
                           fontSize: 16,
                           controller: phoneNumberController,
                            validator: (value) {
                              final RegExp phoneRegex = RegExp(
                                  r'^\+?[0-9]{10,12}$');
                              if (value == null || value.isEmpty) {
                                return 'Phone Number is required';
                              }else if(!phoneRegex.hasMatch(value)) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                         ),
                         const SizedBox(height: 30),
              ],
                     ),
                         CustomMainButton(
                           text: 'Create Account',
                           color: AppColors.yellowColor,
                           textColor: Colors.black,
                           onPressed: () {
                          if(_globalKey.currentState!.validate()){
                            Navigator.pop(context);
                          }
                           },
                         ),

                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account ? ",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColors.yellowColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: AppColors.yellowColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asstes/images/png/usatate_flag.png',
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(width: 15),
                          Image.asset(
                            'asstes/images/png/egypt_flag.png',
                            width: 26,
                            height: 26,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                  ],
              ),
            ),
         ),
                   ),



                //
        );



  }
}
