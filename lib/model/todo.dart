import 'package:flutter/foundation.dart';

/// 最好使用不可变状态。
/// 我们还可以使用像 freezed 这样的package来帮助实现不可变。
@immutable
class Todo {
  const Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  /// 在我们的类中所有的属性都应该是 `final` 的
  final String id;
  final String description;
  final bool completed;

  /// 由于Todo是不可变的，我们实现了一种方法允许克隆内容略有不同的Todo
  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
