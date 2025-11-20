import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

Future<bool?> showDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: AppColors.grayColor,
          title: Text(
            'Delete Account',
            style: TextStyle(color: AppColors.whiteColor),
          ),
          content: Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ],
        ),
  );
}
