import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/AsyncNotifierProvider/http.dart';
import 'package:riverpod_example/AsyncNotifierProvider/todos_async_notifier.dart';
import 'package:riverpod_example/model/todo.dart';

final http = Http();

/// AsyncNotifierProvider
final asyncTodosProvider = AsyncNotifierProvider<TodosAsyncNotifier, List<Todo>>(() {
  return TodosAsyncNotifier();
});
