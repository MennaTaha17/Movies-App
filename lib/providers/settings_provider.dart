
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier{
  String _selectedAvatar = 'asstes/profileImages/image 1.png';
  final List<String> avatarImages = [
    'asstes/profileImages/image 1.png',
    'asstes/profileImages/image 2.png',
    'asstes/profileImages/image 3.png',
    'asstes/profileImages/image 4.png',
    'asstes/profileImages/image 5.png',
    'asstes/profileImages/image 6.png',
    'asstes/profileImages/image 7.png',
    'asstes/profileImages/image 8.png',
    'asstes/profileImages/image 9.png',
  ];
  String localization = 'en';
  String get selectedAvatar => _selectedAvatar;

  SettingsProvider() {
    _loadSelectedAvatar();
  }
 editAvatarImage(String avatar) async {
   _selectedAvatar = avatar;
   notifyListeners();
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('selectedAvatar', avatar);
 }
  void _loadSelectedAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? avatar = prefs.getString('selectedAvatar');
    if (avatar != null) {
      _selectedAvatar = avatar;
      notifyListeners();
    }
  }
  editLocalization(String local){   // TODO shared preferences
    localization = local;
    notifyListeners();
  }
}