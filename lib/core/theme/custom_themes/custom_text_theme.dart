import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';

class CustomTextTheme {
  CustomTextTheme._();

  // Light Textheme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    displayLarge: const TextStyle().copyWith(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 15.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black.withOpacity(0.5),
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black.withOpacity(0.5),
    ),
  );

  // Dark Textheme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    displayLarge: const TextStyle().copyWith(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 15.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.white,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white.withOpacity(0.5),
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.white,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white.withOpacity(0.5),
    ),
  );
}
