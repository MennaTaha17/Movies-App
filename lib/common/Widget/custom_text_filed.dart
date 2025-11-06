import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.icon,
    this.text,
    this.isPassword = false,
    this.validator
  });

  final dynamic icon;
  final String? text;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        validator: validator,
        obscureText: isPassword,
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
          prefixIcon: _buildPrefixIcon(),
          suffixIcon:( text == 'Password'|| text=='Confirm Password')
              ? Icon(
            Icons.visibility_off,
            color: AppColors.whiteColor,
            size: 28,
          )
              : null,
          hintText: text,
          hintStyle: TextStyle(
            color: AppColors.whiteColor.withValues(),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }


  Widget? _buildPrefixIcon() {
    if (icon == null) return null;

    if (icon is Icon) {
      return icon as Icon;
    } else if (icon is IconData) {
      return Icon(icon,
          color: AppColors.whiteColor,size: 28);
    } else {
      return null;
    }
  }
}


_getborder({Color? errorColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: errorColor ?? AppColors.grayColor),
  );
}