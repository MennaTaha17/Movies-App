
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../common/Theme/app_colors.dart';
import '../../providers/settings_provider.dart';

class HeaderProfile extends StatefulWidget {
   const HeaderProfile({super.key});

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
   @override
   Widget build(BuildContext context) {
     final avatarPro = context.watch<SettingsProvider>();
     return Container(
       color: AppColors.grayColor,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Column(
             spacing: 10,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ClipRRect(
                 child: Image.asset(
                   avatarPro.selectedAvatar,
                   fit: BoxFit.fill,
                   height: 120,
                   width: 120,
                 ),
               ),
               Text(
                 'Mark Gamal',
                 style: TextStyle(
                   color: AppColors.whiteColor,
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           ),
           SizedBox(width: 15),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 '0',
                 style: TextStyle(
                   color: AppColors.whiteColor,
                   fontSize: 25,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               Text(
                 "Watch List", // TODo localization
                 style: TextStyle(
                   color: AppColors.whiteColor,
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           ),
           SizedBox(width: 15),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 '0',
                 style: TextStyle(
                   color: AppColors.whiteColor,
                   fontSize: 25,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               Text(
                 "History", // TODO localization
                 style: TextStyle(
                   color: AppColors.whiteColor,
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           ),
         ],
       ),
     );
   }
}
