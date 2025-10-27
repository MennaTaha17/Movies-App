import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({super.key, required this.icon, required this.text});
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // readOnly: true,
      style: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grayColor,
        border: _getborder(),
        focusedBorder: _getborder(),
        enabledBorder: _getborder(),
        errorBorder: _getborder(errorColor: Colors.red),
        prefixIcon: icon,
        hint: Text(
          text,
          style: TextStyle(
            color: AppColors.whiteColor.withValues(),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

_getborder({Color? errorColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: errorColor ?? AppColors.grayColor),
  );
}
