import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';

class CircleAvatarShimmer extends StatelessWidget {
  const CircleAvatarShimmer({
    super.key,
    required this.radius,
  });
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.7),
      highlightColor: AppColors.white,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.grey,
      ),
    );
  }
}
