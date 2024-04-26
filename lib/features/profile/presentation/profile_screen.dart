import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/core/helpers/shimmers/circle_avatar_shimmer.dart';
import 'package:todo_riverpod/core/helpers/shimmers/container_shimmer.dart';
import 'package:todo_riverpod/core/router/app_router.dart';
import 'package:todo_riverpod/core/widgets/custom_elevated_button.dart';
import 'package:todo_riverpod/features/auth/domain/logout_state.dart';
import 'package:todo_riverpod/features/auth/shared/providers.dart';
import 'package:todo_riverpod/features/profile/shared/providers.dart';

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    final logoutProvider = ref.watch(logoutNotifierProvider.notifier);
    ref.listen<LogoutState>(
      logoutNotifierProvider,
      (previous, next) {
        next.maybeMap(
          success: (value) {
            AutoRouter.of(context).pushAndPopUntil(
              const LoginRoute(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              userData.when(
                data: (user) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          user.profileImage.isEmpty
                              ? CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: AppColors.primaryColor,
                                  child: const Icon(
                                    Iconsax.user,
                                    color: AppColors.white,
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: user.profileImage,
                                  placeholder: (context, url) {
                                    return CircleAvatarShimmer(
                                      radius: 30.r,
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: AppColors.primaryColor,
                                      backgroundImage: NetworkImage(
                                        user.profileImage,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return CircleAvatar(
                                      radius: 30.r,
                                      child: const Text(
                                        'Error',
                                      ),
                                    );
                                  },
                                ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  user.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const Text(
                    "Error",
                  );
                },
                loading: () {
                  return Row(
                    children: [
                      CircleAvatarShimmer(
                        radius: 30.r,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContainerShimmer(
                              height: 15.h,
                              width: 1.sw * 0.4,
                              radius: 5.r,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            ContainerShimmer(
                              height: 15.h,
                              width: 1.sw,
                              radius: 5.r,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomElevatedButton(
                height: 40.h,
                text: "Logout",
                onPressed: () {
                  logoutProvider.logout(context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
