import 'package:flutter/cupertino.dart';
import 'package:movies/common/Theme/app_colors.dart';

class ButtonStates extends StatelessWidget {
  const ButtonStates({
    super.key,
    required this.icon,
    required this.text,
    this.color,
    this.width,
    this.height,
  });
  final IconData icon;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 110,
      height: height ?? 47,
      decoration: BoxDecoration(
        color: color ?? AppColors.grayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.yellowColor, size: 22),
          SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
