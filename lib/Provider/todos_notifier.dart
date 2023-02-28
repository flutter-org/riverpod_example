import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/Provider/todo.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }
}
