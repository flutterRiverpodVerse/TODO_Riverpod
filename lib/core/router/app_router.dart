import 'package:auto_route/auto_route.dart';
import 'package:todo_riverpod/bottom_navigation_menu.dart';
import 'package:todo_riverpod/features/auth/presentation/login_screen.dart';
import 'package:todo_riverpod/features/profile/presentation/profile_screen.dart';
import 'package:todo_riverpod/features/todo/presentation/add_todo_screen.dart';
import 'package:todo_riverpod/features/todo/presentation/todo_screen.dart';
import 'package:todo_riverpod/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<CustomRoute> get routes => [
        CustomRoute(
          initial: true,
          page: SplashRoute.page,
        ),
        CustomRoute(
          page: LoginRoute.page,
        ),
        CustomRoute(
          page: BottomNavigationMenuRoute.page,
        ),
        CustomRoute(
          page: TodoRoute.page,
        ),
        CustomRoute(
          page: ProfileRoute.page,
        ),
        CustomRoute(
          page: AddTodoRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
      ];
}
