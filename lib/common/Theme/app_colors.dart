import 'dart:ui';

class AppColors {
  static const Color blackColor = Color(0xff121312);
  static const Color grayColor = Color(0xff282A28);
  static const Color yellowColor = Color(0xffFFBB3B);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color redColor = Color(0xffE82626);
  static const Color greenColor = Color(0xff57AA53);

  // يمكن تعيين اللون لاحقاً أو جعله افتراضي
  static Color backgroundColor = blackColor;

  // دالة لتطبيق الشفافية بطريقة آمنة
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
