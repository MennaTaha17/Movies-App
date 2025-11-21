import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
    required this.textColor, this.icon,
  });
  final String text;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
              )),
              
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                  if(icon != null)
                    Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(icon),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
