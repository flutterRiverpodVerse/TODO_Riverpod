// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/features/todo/domain/ab_todo_remote_services.dart';
import 'package:todo_riverpod/features/todo/domain/todo_model.dart';

class TodoRemoteServices extends AbTodoRemoteServices {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  TodoRemoteServices({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<List<TodoModel>> fetchTodos() async {
    List<TodoModel> todoList = [];
    try {
      final data = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('todos')
          .get();
      todoList = data.docs.map((todo) => TodoModel.fromSnapshot(todo)).toList();
    } catch (e) {
      AppConstants.showSnackbar(
        backgroundColor: AppColors.error,
        text: e.toString(),
      );
    }
    return todoList;
  }

  @override
  Future<void> addTodo({
    required TodoModel todo,
  }) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('todos')
          .doc(todo.id)
          .set(
            todo.toJson(),
          );
    } catch (e) {
      AppConstants.showSnackbar(
        backgroundColor: AppColors.error,
        text: e.toString(),
      );
    }
  }

  @override
  Future<void> markTodoCompleted({
    required String todoId,
    required bool value,
  }) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('todos')
          .doc(todoId)
          .update(
        {
          "isCompleted": value,
        },
      );
    } catch (e) {
      AppConstants.showSnackbar(
        backgroundColor: AppColors.error,
        text: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteTodo({
    required String todoId,
  }) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('todos')
          .doc(todoId)
          .delete();
    } catch (e) {
      AppConstants.showSnackbar(
        backgroundColor: AppColors.error,
        text: e.toString(),
      );
    }
  }
}
