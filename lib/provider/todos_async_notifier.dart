import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/http.dart';
import 'package:riverpod_example/model/todo.dart';

/// Notifier类将会被传递给我们的NotifierProvider。
/// 这个类不应该在其“state”属性之外暴露状态，也就是说没有公共的获取属性的方法！
/// 这个类上的公共方法将允许UI修改它的状态。
final http = Http();

class TodosAsyncNotifier extends AsyncNotifier<List<Todo>> {
  Future<List<Todo>> _fetchTodo() async {
    final json = await http.get('api/todos');
    final decode = jsonDecode(json);
    final todos = decode;
    // final todos = decode as List<Map<String, dynamic>>;
    return todos.map<Todo>((todo) => Todo.fromJson(todo)).toList();
  }

  @override
  Future<List<Todo>> build() async {
    // 从远程仓库获取初始的待办清单
    return _fetchTodo();
  }

  Future<void> addTodo(Todo todo) async {
    // 将当前状态设置为加载中
    state = const AsyncValue.loading();
    // 将新的待办清单添加到远程仓库
    state = await AsyncValue.guard(() async {
      await http.post('api/todos', todo.toJson());
      return _fetchTodo();
    });
  }

  /// 让我们允许删除待办清单
  Future<void> removeTodo(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.delete('api/todos/$todoId');
      return _fetchTodo();
    });
  }

  /// 让我们把待办清单标记为已完成
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.patch(
        'api/todos/$todoId',
        <String, dynamic>{'completed': true},
      );
      return _fetchTodo();
    });
  }
}
