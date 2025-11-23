
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../common/Theme/app_colors.dart';
import '../../network/auth_services.dart';
import '../../providers/settings_provider.dart';
import '../../providers/watch_list_provider.dart';

class HeaderProfile extends StatefulWidget {
   const HeaderProfile({super.key});

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUser();
  }
  void _loadUser() async {
    final user = await AuthServices.getUserInfo();
    if (user != null) {
      setState(() {
        nameController.text = user.name;
      });
    }
  }
   @override
   Widget build(BuildContext context) {
     final avatarPro = context.watch<SettingsProvider>();
     final watchListPro = context.watch<WatchListProvider>();
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
                 nameController.text,
                 style: TextStyle(
                   color: AppColors.whiteColor,
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           ),
           SizedBox(width: 15),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   '${watchListPro.watchList.length}',
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
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ],
             ),
           ),
           SizedBox(width: 15),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   '${watchListPro.history.length}',
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
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
   }
}
