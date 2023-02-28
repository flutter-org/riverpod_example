import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/Provider/todo.dart';
import 'package:riverpod_example/Provider/todos_notifier.dart';

/// 在所有的provider中 Provider 是最基础的。它创造了一个值……差不多就是这样。
/// Provider 一般用在：
/// * 缓存计算。
/// * 向其他provider(比如Repository/HttpClient)暴露一个值。
/// * 为测试或widget提供重写值的方法。
/// * 减少 provider/widget 的重新构建，不必使用 select。

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

final completedTodosProvider = Provider<List<Todo>>((ref) {
  /// 我们从todosProvider获取所有待办清单
  final todos = ref.watch(todosProvider);

  /// 我们只返回完成的待办事项
  return todos.where((todo) => todo.isCompleted).toList();
});

class ProviderPage extends StatelessWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final completedTodos = ref.watch(completedTodosProvider);

          /// TODO show the todos using a ListView/GridView/...
          return ListView();
        },
      ),
    );
  }
}
