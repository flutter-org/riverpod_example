import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/todo.dart';

/// Notifier类将会被传递给我们的NotifierProvider。
/// 这个类不应该在其“state”属性之外暴露状态，也就是说没有公共的获取属性的方法！
/// 这个类上的公共方法将允许UI修改它的状态。
class TodosNotifier extends Notifier<List<Todo>> {
  /// 我们将待办清单的列表初始化
  @override
  List<Todo> build() {
    return [
      const Todo(id: '1', description: 'notifier1', completed: false),
      const Todo(id: '2', description: 'notifier2', completed: false),
      const Todo(id: '3', description: 'notifier3', completed: true),
    ];
  }

  /// 让我们添加UI添加待办清单
  void addTodo(Todo todo) {
    // 由于状态是不可变的，因此不允许执行 `state.add(todo)`。
    // 相反，我们应该创建一个包含以前的项目和新的项目的待办清单列表。
    // 在这里使用Dart的扩展运算符很有用！
    state = [...state, todo];
    // 不需要调用“notifyListeners”或其他类似的方法。
    // 直接 “state =” 就能自动在需要时重新构建UI。
  }

  /// 让我们允许删除待办清单
  void removeTodo(String todoId) {
    // 同样我们的状态是不可变的。
    // 所以我们创建了一个新的列表，而不是改变现存的列表。
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // 我们只标记完成的待办清单
        if (todo.id == todoId)
          // 再一次因为我们的状态是不可变的，所以我们需要创建待办清单的副本，
          // 我们使用之前实现的copyWith方法来实现。
          todo.copyWith(completed: !todo.completed)
        else
          // 其他未修改的待办清单
          todo,
    ];
  }
}
