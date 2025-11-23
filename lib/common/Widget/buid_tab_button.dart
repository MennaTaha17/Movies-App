
import 'package:flutter/material.dart';

import '../Theme/app_colors.dart';

class BuildTabButton extends StatelessWidget {
  const BuildTabButton({ required this.icon,
  required this.text,
  required this.selected,
  required this.onTap,required this.color});
  final Color color;
final String text;
final Widget icon;
final bool selected;
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.grayColor,
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
