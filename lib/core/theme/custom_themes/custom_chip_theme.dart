import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChipTheme {
  CustomChipTheme._();

  //Light
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: AppColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(
      color: AppColors.black,
    ),
    selectedColor: AppColors.primaryColor,
    padding: EdgeInsets.symmetric(
      horizontal: 8.w,
      vertical: 10.h,
    ),
    checkmarkColor: AppColors.white,
  );

  //Dark
  static ChipThemeData darkChipThemeData = ChipThemeData(
    disabledColor: AppColors.grey,
    labelStyle: const TextStyle(
      color: AppColors.black,
    ),
    selectedColor: AppColors.primaryColor,
    padding: EdgeInsets.symmetric(
      horizontal: 8.w,
      vertical: 10.h,
    ),
    checkmarkColor: AppColors.white,
  );
}
