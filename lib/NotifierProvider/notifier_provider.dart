import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/NotifierProvider/todos_notifier.dart';
import 'package:riverpod_example/model/todo.dart';

/// NotifierProvider
final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});
