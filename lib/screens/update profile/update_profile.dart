import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';
import 'package:movies/network/auth_services.dart';
import 'package:provider/provider.dart';
import '../../common/Widget/custom_main_button.dart';
import '../../common/Widget/custom_text_filed.dart';
import '../../common/Widget/show_delete_dialog.dart';
import '../../providers/settings_provider.dart';
import '../auth/forget_password_screen.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});
  static const String routeName = '/updateProfile';
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  void _showAvatarPicker() {
    final avatarPro = context.read<SettingsProvider>();
    showModalBottomSheet(
      backgroundColor: AppColors.grayColor,
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(19.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatarPro.avatarImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 18,
              mainAxisSpacing: 19,
            ),
            itemBuilder: (context, index) {
              final currentAvatar = avatarPro.avatarImages[index];
              final isSelected = currentAvatar ==   avatarPro.selectedAvatar;
              return GestureDetector(
                onTap: () {
                  setState(() {
                avatarPro.editAvatarImage(currentAvatar);
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
    final avatarPro = context.watch<SettingsProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false, // The screen will not move
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.yellowColor),
        title: Text(
          "Pick Avatar",               // TODO localization
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
                    avatarPro.selectedAvatar,
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
              fontSize: 20,
              icon: Icon(Icons.person, size: 30, color: AppColors.whiteColor),
            ),
            SizedBox(height: 20),
            CustomTextFiled(
              text: "01200000000", //TODO : logic
              fontSize: 20,
              icon: Icon(Icons.call, size: 30, color: AppColors.whiteColor),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ForgetPasswordScreen.routeName);
              },
              child: Text(
                "Reset Password",           // TODO localization
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Spacer(),
            CustomMainButton(
              text: "Delete Account",                  // TODO localization
              color: AppColors.redColor,
              textColor: AppColors.whiteColor,
              onPressed: () async {
                bool? confirm = await showDeleteDialog(context);
                if (confirm == true) {
                  try {
                    await AuthServices.deleteUser();
                    await Flushbar(
                      duration: Duration(seconds: 3),
                      backgroundColor: AppColors.greenColor,
                      title: "Success",                // TODO localization
                      message: "The account has been successfully deleted.",          // TODO localization
                    ).show(context);
                    Navigator.of(context).pushReplacementNamed('/loginScreen');
                  } catch (e) {
                    await Flushbar(
                      duration: Duration(seconds: 3),
                      title: "Error.",                // TODO localization
                      message: e.toString(),
                      backgroundColor: AppColors.redColor,
                    ).show(context);
                  }
                }
              },
            ),
            SizedBox(height: 20),
            CustomMainButton(
              text: "Update Data",              // TODO localization
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
