import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/todo.dart';
import 'package:riverpod_example/StateNotifierProvider/todos_state_notifier.dart';

/// StateNotifierProvider
final stateTodosProvider = StateNotifierProvider<TodosStateNotifier, List<Todo>>((ref) {
  return TodosStateNotifier();
});
