import 'package:todo_riverpod/features/todo/domain/todo_model.dart';

abstract class AbTodoRemoteServices {
  Future<List<TodoModel>> fetchTodos();

  Future<void> addTodo({
    required TodoModel todo,
  });

  Future<void> markTodoCompleted({
    required String todoId,
    required bool value,
  });

  Future<void> deleteTodo({
    required String todoId,
  });
}
