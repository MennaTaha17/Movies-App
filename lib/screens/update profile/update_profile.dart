import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import '../../common/Widget/custom_main_button.dart';
import '../../common/Widget/custom_text_filed.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});
  static const String routName = '/updateProfile';
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final List<String> avatarImages = [
    'asstes/profileImages/image 1.png',
    'asstes/profileImages/image 2.png',
    'asstes/profileImages/image 3.png',
    'asstes/profileImages/image 4.png',
    'asstes/profileImages/image 5.png',
    'asstes/profileImages/image 6.png',
    'asstes/profileImages/image 7.png',
    'asstes/profileImages/image 8.png',
    'asstes/profileImages/image 9.png',
  ];
  String selectedAvatar = 'asstes/profileImages/image 1.png';
  void _showAvatarPicker() {
    showModalBottomSheet(
      backgroundColor: AppColors.grayColor,
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(19.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatarImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 18,
              mainAxisSpacing: 19,
            ),
            itemBuilder: (context, index) {
              final currentAvatar = avatarImages[index];
              final isSelected = currentAvatar == selectedAvatar;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = currentAvatar;
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.yellowColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.yellowColor,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      currentAvatar,
                      fit: BoxFit.fill,
                      width: 86,
                      height: 86,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // The screen will not move
      appBar: AppBar(
        title: Text(
          "Pick Avatar",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.yellowColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _showAvatarPicker,
                child: ClipRRect(
                  child: Image.asset(
                    selectedAvatar,
                    fit: BoxFit.fill,
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomTextFiled(
              text: "Mark Gamal", //TODO : logic
              icon: Icon(Icons.person, size: 30, color: AppColors.whiteColor),
            ),
            SizedBox(height: 20),
            CustomTextFiled(
              text: "01200000000", //TODO : logic
              icon: Icon(Icons.call, size: 30, color: AppColors.whiteColor),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {}, //TODO : logic
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Spacer(),
            CustomMainButton(
              text: "Delete Account",
              color: AppColors.redColor,
              textColor: AppColors.whiteColor,
              onPressed: () {}, //TODO : logic
            ),
            SizedBox(height: 20),
            CustomMainButton(
              text: "Update Data",
              color: AppColors.yellowColor,
              textColor: AppColors.blackColor,
              onPressed: () {}, //TODO : logic
            ),
          ],
        ),
      ),
    );
  }
}
