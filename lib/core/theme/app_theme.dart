import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_app_bar_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_bottom_sheet_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_check_box_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_chip_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_elevated_button_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_outlined_button_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_text_field_theme.dart';
import 'package:todo_riverpod/core/theme/custom_themes/custom_text_theme.dart';

class AppTheme {
  AppTheme._();

// Light
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTextTheme,
    chipTheme: CustomChipTheme.lightChipThemeData,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: CustomCheckBoxTheme.lightCheckboxThemeData,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetThemeData,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonThemeData,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonThemeData,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
  );

// Dark
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: CustomTextTheme.darkTextTheme,
    chipTheme: CustomChipTheme.darkChipThemeData,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: CustomCheckBoxTheme.darkCheckboxThemeData,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetThemeData,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonThemeData,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonThemeData,
    inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
  );
}
