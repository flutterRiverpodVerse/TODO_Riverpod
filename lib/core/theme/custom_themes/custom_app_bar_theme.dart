import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

//Light
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.black,
    ),
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColors.black,
      size: 24.sp,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.black,
      size: 24.sp,
    ),
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),
  );

//Dark
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.black,
    ),
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColors.white,
      size: 24.sp,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.white,
      size: 24.sp,
    ),
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),
  );
}
