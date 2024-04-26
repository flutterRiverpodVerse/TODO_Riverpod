import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/gen/assets.gen.dart';

class Loader {
  static void openLoadingDialog({
    required BuildContext context,
  }) {
    showDialog(
      useSafeArea: false,
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Container(
            color: AppConstants.isDarkMode(context: context)
                ? AppColors.black
                : AppColors.white,
            width: 1.sw,
            height: 1.sh,
            child: Center(
              child: Lottie.asset(
                Assets.animations.loadingAnimation,
              ),
            ),
          ),
        );
      },
    );
  }

  static void stopLoading({
    required BuildContext context,
  }) {
    AutoRouter.of(context).maybePop();
  }
}
