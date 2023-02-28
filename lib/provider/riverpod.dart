import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/Provider/todos_notifier.dart';
import 'package:riverpod_example/model/todo.dart';
import 'package:riverpod_example/provider/async_todos_notifier.dart';

final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});

final completedTodosProvider = Provider<List<Todo>>((ref) {
  /// 我们从todosProvider获取所有待办清单
  final todos = ref.watch(todosProvider);

  /// 我们只返回完成的待办事项
  return todos.where((todo) => todo.completed).toList();
});

/// 最后，我们使用NotifierProvider来允许UI与我们的TodosNotifier类交互。
final asyncTodosProvider = AsyncNotifierProvider<AsyncTodosNotifier, List<Todo>>(() {
  return AsyncTodosNotifier();
});
