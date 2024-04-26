// ignore_for_file: use_build_context_synchronously, unused_result

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/features/todo/domain/todo_model.dart';
import 'package:todo_riverpod/features/todo/shared/providers.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class AddTodoScreen extends StatefulHookConsumerWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final dateController = useTextEditingController();
    final timeController = useTextEditingController();

    DateTime? date;

    return GestureDetector(
      onTap: () {
        AppConstants.hideKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Todo",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Todo Name",
                        labelStyle:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      controller: descController,
                      maxLines: null,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(200),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Description",
                        labelStyle:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: dateController,
                            readOnly: true,
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                keyboardType: TextInputType.datetime,
                                initialDate: DateTime.now().toLocal(),
                                firstDate: DateTime.now()
                                    .add(
                                      const Duration(seconds: 5),
                                    )
                                    .toLocal(),
                                lastDate: DateTime(2050).toLocal(),
                                fieldHintText: 'MM/dd/yyyy',
                              );
                              if (pickedDate != null) {
                                final pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (pickedTime != null) {
                                  date = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );

                                  dateController.text =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                  timeController.text =
                                      pickedTime.format(context);

                                  log(date.toString());
                                }
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: "Date",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: timeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: "Time",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 1.sw,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (date != null) {
                              ref
                                  .read(todoRemoteServicesProvider)
                                  .addTodo(
                                    todo: TodoModel(
                                      id: const Uuid().v1(),
                                      name: nameController.text.trim(),
                                      desc: descController.text.trim(),
                                      date: date!.toUtc(),
                                      isCompleted: false,
                                    ),
                                  )
                                  .whenComplete(() {
                                AutoRouter.of(context).maybePop();
                                ref.refresh(todoListProvider);
                              });
                            }
                          }
                        },
                        child: const Text(
                          "Add",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
