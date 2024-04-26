import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/core/router/app_router.dart';
import 'package:todo_riverpod/core/widgets/custom_elevated_button.dart';
import 'package:todo_riverpod/features/auth/domain/login_state.dart';
import 'package:todo_riverpod/features/auth/shared/providers.dart';
import 'package:todo_riverpod/gen/assets.gen.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginNotifierProvider.notifier);
    ref.listen<LoginState>(
      loginNotifierProvider,
      (prev, next) {
        next.maybeMap(
          authenticated: (value) {
            AutoRouter.of(context).pushAndPopUntil(
              const BottomNavigationMenuRoute(),
              predicate: (route) => false,
            );
          },
          failure: (value) {
            AppConstants.showSnackbar(
              backgroundColor: AppColors.error,
              text: value.authFailure.message,
            );
          },
          orElse: () {},
        );
      },
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                Assets.animations.loginScreenAnimation,
                height: 1.sh * 0.7,
                width: 1.sw,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: CustomElevatedButton(
                  height: 40.h,
                  text: "SignIn with Google",
                  onPressed: () {
                    loginProvider.signInWithGoogle(context: context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
