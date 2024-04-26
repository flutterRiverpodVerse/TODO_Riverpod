// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/features/todo/domain/todo_model.dart';
import 'package:todo_riverpod/features/todo/shared/providers.dart';

class ParticularTodoWidget extends StatelessWidget {
  const ParticularTodoWidget({
    super.key,
    required this.isDarkMode,
    required this.todo,
    required this.ref,
  });

  final bool isDarkMode;
  final TodoModel todo;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      margin: EdgeInsets.only(
        top: 10.h,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.black.withOpacity(0.8) : AppColors.white,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            spreadRadius: 2.r,
            blurRadius: 7.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (DateTime.now().toLocal().day - todo.date.toLocal().day) >= 1
              ? const SizedBox.shrink()
              : Checkbox(
                  checkColor: AppColors.white,
                  activeColor: AppColors.primaryColor,
                  value: todo.isCompleted,
                  onChanged: (value) {
                    ref.read(todoRemoteServicesProvider).markTodoCompleted(
                          todoId: todo.id,
                          value: value!,
                        );
                    ref.refresh(todoListProvider);
                  },
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Text(
                        todo.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          ref
                              .read(todoRemoteServicesProvider)
                              .deleteTodo(todoId: todo.id);
                          ref.refresh(todoListProvider);
                        },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  todo.desc,
                  maxLines: null,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Date - ${DateFormat("dd MMM , hh:mm a").format(todo.date.toLocal())}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                (DateTime.now().toLocal().day - todo.date.toLocal().day) >= 1
                    ? Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Expired ${todo.isCompleted ? "after completion" : "but not completed"}",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          todo.isCompleted
                              ? Text(
                                  "Completed",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.success,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              : Text(
                                  "Ongoing",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
