import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/common/Widget/custom_text_filed.dart';
import 'package:movies/common/Widget/custom_main_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                     children: const [
                       CustomTextFiled(
                         icon: Icons.person,
                         text: 'Name',
                       ),
                       SizedBox(height: 20),
                       CustomTextFiled(
                         icon: Icons.email,
                         text: 'Email',
                       ),
                       SizedBox(height: 20),
                       CustomTextFiled(
                         icon: Icons.lock,
                         text: 'Password',
                         isPassword: true,
                       ),
                       SizedBox(height: 20),
                       CustomTextFiled(
                         icon: Icons.lock,
                         text: 'Confirm Password',
                         isPassword: true,
                       ),
                       SizedBox(height: 20),
                       CustomTextFiled(
                         icon: Icons.phone,
                         text: 'Phone Number',
                       ),
                       const SizedBox(height: 30),
],
                   ),
                       CustomMainButton(
                         text: 'Create One',
                         color: AppColors.yellowColor,
                         textColor: Colors.black,
                         onPressed: () {

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



                //
        );



  }
}
