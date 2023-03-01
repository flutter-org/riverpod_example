import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/todo.dart';

class TodosStateNotifier extends StateNotifier<List<Todo>> {
  TodosStateNotifier() : super([
    const Todo(id: '1', description: 'state1', completed: false),
    const Todo(id: '2', description: 'state2', completed: false),
    const Todo(id: '3', description: 'state3', completed: true),
  ]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(completed: !todo.completed) else todo,
    ];
  }
}
