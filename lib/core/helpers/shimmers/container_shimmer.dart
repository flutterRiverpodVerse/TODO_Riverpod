import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });
  final double height, width, radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.7),
      highlightColor: AppColors.white,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
      ),
    );
  }
}
