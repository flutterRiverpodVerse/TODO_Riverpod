// ignore_for_file: unused_result

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/core/helpers/shimmers/container_shimmer.dart';
import 'package:todo_riverpod/core/router/app_router.dart';
import 'package:todo_riverpod/features/profile/shared/providers.dart';
import 'package:todo_riverpod/features/todo/domain/todo_model.dart';
import 'package:todo_riverpod/features/todo/shared/providers.dart';
import 'package:todo_riverpod/features/todo/widgets/particular_todo_widget.dart';

@RoutePage()
class TodoScreen extends StatefulHookConsumerWidget {
  const TodoScreen({
    super.key,
  });

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  List<TodoModel> allTodos = [];
  List<TodoModel> ongoingTodos = [];
  List<TodoModel> completedTodos = [];
  @override
  Widget build(BuildContext context) {
    final isDarkMode = AppConstants.isDarkMode(context: context);
    final pageController = usePageController(
      initialPage: 0,
    );
    final userData = ref.watch(userDataProvider);
    final todoData = ref.watch(todoListProvider);

    final presentDay = useState<DateTime>(DateTime.now().toLocal());
    final listOfModes = [
      "All",
      "Ongoing",
      "Completed",
    ];
    final selectedMode = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: userData.when(
          data: (user) {
            return Text(
              "Welcome ${user.name.split(" ").first} ,",
            );
          },
          error: (error, stackTrace) {
            return const Icon(
              Icons.error,
            );
          },
          loading: () {
            return ContainerShimmer(
              height: 5.h,
              width: 100.w,
              radius: 3.r,
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your tasks",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18.sp,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy, EEEE')
                            .format(presentDay.value),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            keyboardType: TextInputType.datetime,
                            initialDate: presentDay.value,
                            firstDate: DateTime(2010).toLocal(),
                            lastDate: DateTime(2050).toLocal(),
                            fieldHintText: 'MM/dd/yyyy',
                          );
                          if (pickedDate != null) {
                            presentDay.value = pickedDate.toLocal();
                            selectedMode.value = 0;
                            pageController.jumpToPage(0);
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 20.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listOfModes.length,
                      itemBuilder: (context, index) {
                        final mode = listOfModes[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 20.w,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              selectedMode.value = index;
                              pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.fastEaseInToSlowEaseOut,
                              );
                            },
                            child: Text(
                              mode,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: selectedMode.value == index
                                        ? 17.sp
                                        : 16.sp,
                                    color: selectedMode.value == index
                                        ? AppColors.primaryColor
                                        : null,
                                    fontWeight: selectedMode.value == index
                                        ? FontWeight.bold
                                        : null,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                todoData.when(
                  data: (todoList) {
                    allTodos = todoList
                        .where((element) =>
                            element.date.toLocal().year ==
                                presentDay.value.year &&
                            element.date.toLocal().month ==
                                presentDay.value.month &&
                            element.date.toLocal().day == presentDay.value.day)
                        .toList();
                    return allTodos.isEmpty
                        ? SizedBox(
                            height: 1.sh * 0.5,
                            width: 1.sw,
                            child: Center(
                              child: Text(
                                "No todos available",
                                style: Theme.of(context).textTheme.titleMedium!,
                              ),
                            ),
                          )
                        : ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: allTodos.length,
                                  itemBuilder: (context, index) {
                                    final todo = allTodos[index];
                                    return ParticularTodoWidget(
                                      isDarkMode: isDarkMode,
                                      todo: todo,
                                      ref: ref,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text(
                        "error",
                      ),
                    );
                  },
                  loading: () {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(
                            8.spMax,
                          ),
                          child: ContainerShimmer(
                            height: 60.h,
                            width: 1.sw,
                            radius: 5.r,
                          ),
                        );
                      },
                    );
                  },
                ),
                todoData.when(
                  data: (todoList) {
                    ongoingTodos = todoList
                        .where((element) =>
                            element.isCompleted == false &&
                            (element.date.toLocal().year ==
                                    presentDay.value.year &&
                                element.date.toLocal().month ==
                                    presentDay.value.month &&
                                element.date.toLocal().day ==
                                    presentDay.value.day))
                        .toList();
                    return ongoingTodos.isEmpty
                        ? SizedBox(
                            height: 1.sh * 0.5,
                            width: 1.sw,
                            child: Center(
                              child: Text(
                                "No ongoing todos available",
                                style: Theme.of(context).textTheme.titleMedium!,
                              ),
                            ),
                          )
                        : ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: ongoingTodos.length,
                                  itemBuilder: (context, index) {
                                    final todo = ongoingTodos[index];
                                    return ParticularTodoWidget(
                                      isDarkMode: isDarkMode,
                                      todo: todo,
                                      ref: ref,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text(
                        "error",
                      ),
                    );
                  },
                  loading: () {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(
                            8.spMax,
                          ),
                          child: ContainerShimmer(
                            height: 60.h,
                            width: 1.sw,
                            radius: 5.r,
                          ),
                        );
                      },
                    );
                  },
                ),
                todoData.when(
                  data: (todoList) {
                    completedTodos = todoList
                        .where((element) =>
                            element.isCompleted == true &&
                            (element.date.toLocal().year ==
                                    presentDay.value.year &&
                                element.date.toLocal().month ==
                                    presentDay.value.month &&
                                element.date.toLocal().day ==
                                    presentDay.value.day))
                        .toList();
                    return completedTodos.isEmpty
                        ? SizedBox(
                            height: 1.sh * 0.5,
                            width: 1.sw,
                            child: Center(
                              child: Text(
                                "No completed todos available",
                                style: Theme.of(context).textTheme.titleMedium!,
                              ),
                            ),
                          )
                        : ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: completedTodos.length,
                                  itemBuilder: (context, index) {
                                    final todo = completedTodos[index];
                                    return ParticularTodoWidget(
                                      isDarkMode: isDarkMode,
                                      todo: todo,
                                      ref: ref,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text(
                        "error",
                      ),
                    );
                  },
                  loading: () {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(
                            8.spMax,
                          ),
                          child: ContainerShimmer(
                            height: 60.h,
                            width: 1.sw,
                            radius: 5.r,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          AutoRouter.of(context).push(
            const AddTodoRoute(),
          );
        },
        label: Text(
          "Add todo",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
    );
  }
}
