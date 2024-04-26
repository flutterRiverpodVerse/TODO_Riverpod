import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/shared/providers.dart';
import 'package:todo_riverpod/features/todo/domain/ab_todo_remote_services.dart';
import 'package:todo_riverpod/features/todo/domain/todo_model.dart';
import 'package:todo_riverpod/features/todo/infra/todo_remote_services.dart';

final todoRemoteServicesProvider = Provider<AbTodoRemoteServices>(
  (ref) {
    return TodoRemoteServices(
      firebaseAuth: ref.watch(firebaseAuthProvider),
      firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    );
  },
);

final todoListProvider = FutureProvider<List<TodoModel>>(
  (ref) async {
    return ref.watch(todoRemoteServicesProvider).fetchTodos();
  },
);
