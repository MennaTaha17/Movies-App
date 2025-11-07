import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    this.icon,
    this.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.fontSize,
  });

  final dynamic icon;
  final String? text;
  final bool isPassword;
  final String? Function(String?)? validator;
  final double? fontSize;
 final TextEditingController? controller;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        cursorColor: AppColors.whiteColor,
        validator: widget.validator,
        obscureText: widget.isPassword,
        controller: widget.controller,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.grayColor,
         border: _getborder(),
          focusedBorder: _getborder(),
          enabledBorder: _getborder(),
          errorBorder: _getborder(errorColor: Colors.red),
          focusedErrorBorder: _getborder(errorColor: Colors.red),
          prefixIcon: _buildPrefixIcon(),
          suffixIcon:( widget.text == 'Password'|| widget.text=='Confirm Password')
              ? Icon(
            Icons.visibility_off,
            color: AppColors.whiteColor,
            size: 28,
          )
              : null,
          hintText: widget.text,
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
    if (widget.icon == null) return null;

    if (widget.icon is Icon) {
      return widget.icon as Icon;
    } else if (widget.icon is IconData) {
      return Icon(widget.icon,
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