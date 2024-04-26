import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/features/profile/presentation/profile_screen.dart';
import 'package:todo_riverpod/features/todo/presentation/todo_screen.dart';

@RoutePage()
class BottomNavigationMenuScreen extends StatefulHookConsumerWidget {
  const BottomNavigationMenuScreen({super.key});

  @override
  ConsumerState<BottomNavigationMenuScreen> createState() =>
      _BottomNavigationMenuScreenState();
}

class _BottomNavigationMenuScreenState
    extends ConsumerState<BottomNavigationMenuScreen> {
  final screens = [
    const TodoScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final isDarkMode = AppConstants.isDarkMode(context: context);
    final currentIndex = useState<int>(0);
    return Scaffold(
      body: SafeArea(
        child: screens[currentIndex.value],
      ),
      bottomNavigationBar: NavigationBar(
        height: kBottomNavigationBarHeight.h,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5.r,
          ),
        ),
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.light,
        indicatorColor: isDarkMode
            ? AppColors.white.withOpacity(0.1)
            : AppColors.black.withOpacity(0.1),
        selectedIndex: currentIndex.value,
        onDestinationSelected: (value) {
          currentIndex.value = value;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Iconsax.note_square,
            ),
            label: "Todos",
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.user,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
