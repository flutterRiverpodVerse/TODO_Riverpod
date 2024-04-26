import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  //Light
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.darkGrey,
    suffixIconColor: AppColors.darkGrey,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: AppColors.black.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColors.grey,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: Colors.black12,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: Colors.orange,
      ),
    ),
  );

  //Dark
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.darkGrey,
    suffixIconColor: AppColors.darkGrey,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14.sp,
      color: AppColors.white,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14.sp,
      color: AppColors.white,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: AppColors.white.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColors.grey,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColors.white,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: Colors.orange,
      ),
    ),
  );
}
