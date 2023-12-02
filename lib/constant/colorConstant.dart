import 'package:flutter/material.dart';

class AppColors {
  static const Color kPrimaryColor = Color(0xffFF9700);
  static const Color kAccentColor = Color(0xff1793C6);

  static MaterialColor kPrimarySwatch = MaterialColor(0xff2A41CB, swatch);

  static Map<int, Color> swatch = {
    50: kPrimaryColor.withOpacity(.1),
    100: kPrimaryColor.withOpacity(.2),
    200: kPrimaryColor.withOpacity(.3),
    300: kPrimaryColor.withOpacity(.4),
    400: kPrimaryColor.withOpacity(.5),
    500: kPrimaryColor.withOpacity(.6),
    600: kPrimaryColor.withOpacity(.7),
    700: kPrimaryColor.withOpacity(.8),
    800: kPrimaryColor.withOpacity(.9),
    900: kPrimaryColor.withOpacity(1),
  };

  static const Color kBackgroundColor = Color(0xfff3f5ff);
  static const Color kGreenColor = Color(0xff0ebc40);
  static const Color kWhiteColor = Color(0xffffffff);
  static const Color kBlackColor = Color(0xff000000);
  static const Color kRedColor = Color(0xffd70000);
  static const Color kGreyColor = Color(0xffc5c5c5);
  static const Color kLightTextColor = Color(0xffc0cbf3);
  static const Color kProgressRemainingColor = Color(0xffeaedff);
  static const Color kExamItemBGColor = Color(0xffDCE4FF);
  static Color kBorderColor = const Color(0xff2A41CB).withOpacity(0.8);
  static Color kPrimaryColor5P = const Color(0xff2A41CB).withOpacity(0.5);
  static Color kPrimaryColor2P = const Color(0xff2A41CB).withOpacity(0.02);
  static const kbgGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color(0xFF849EFF),
      Color(0xFFC0CBF3),
    ],
  );
}
