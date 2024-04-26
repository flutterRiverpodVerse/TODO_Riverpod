import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/router/app_router.dart';
import 'package:todo_riverpod/features/auth/domain/login_state.dart';
import 'package:todo_riverpod/features/auth/shared/providers.dart';
import 'package:todo_riverpod/gen/assets.gen.dart';

final initialProvider = FutureProvider<Unit>(
  (ref) {
    final userData = ref.read(loginNotifierProvider.notifier);
    userData.isUserLoggedIn();
    return unit;
  },
);

@RoutePage()
class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(initialProvider, (previous, next) {});
    ref.listen<LoginState>(
      loginNotifierProvider,
      (prev, next) {
        Future.delayed(
          const Duration(milliseconds: 2800),
          () {
            next.maybeMap(
              authenticated: (value) {
                AutoRouter.of(context).pushAndPopUntil(
                  const BottomNavigationMenuRoute(),
                  predicate: (route) => false,
                );
              },
              unauthenticated: (value) {
                AutoRouter.of(context).pushAndPopUntil(
                  const LoginRoute(),
                  predicate: (route) => false,
                );
              },
              orElse: () {},
            );
          },
        );
      },
    );
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            Assets.animations.splashScreenAnimation,
            height: 1.sh * 0.7,
            width: 1.sw,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
