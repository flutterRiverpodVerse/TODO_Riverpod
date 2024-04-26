import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //App basic colors
  static const Color primaryColor = Color(0xff3f5bd9);
  static const Color secondaryColor = Color(0xff5223b8);
  static const Color accent = Color(0xffb0c7ff);

  //Text colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff6C7570);
  static const Color textWhite = Colors.white;

  //Backgound colors
  static const Color light = Color(0xffF6F6F6);
  static const Color dark = Color(0xff272727);

  //Backgound container colors
  static const Color lightContainer = Color(0xffF6F6F6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  //Button colors
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondary = Color(0xff6C7570);
  static const Color buttonDisabled = Color(0xffC4C4C4);

  //Border colors
  static const Color borderPrimary = Color(0xffD9D9D9);
  static const Color borderSecondary = Color(0xffE6E6E6);

  //Error and validation colors
  static const Color error = Color(0xffD32F2F);
  static const Color success = Color(0xff388E3C);
  static const Color warning = Color(0xffF57C00);
  static const Color info = Color(0xff1976D2);

  //Neutral Shades
  static const Color black = Color(0xff232323);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color.fromARGB(255, 170, 170, 170);
  static const Color lightGrey = Color(0xffF9F9F9);
  static const Color softGrey = Color(0xffF4F4F4);
  static const Color darkGrey = Color(0xff939393);
  static const Color darkerGrey = Color(0xff4F4F4F);
}
