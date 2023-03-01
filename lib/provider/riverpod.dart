import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/Provider/todos_notifier.dart';
import 'package:riverpod_example/model/product.dart';
import 'package:riverpod_example/model/todo.dart';
import 'package:riverpod_example/provider/todos_async_notifier.dart';
import 'package:riverpod_example/provider/todos_state_notifier.dart';
import 'package:riverpod_example/widgets/pages/state_provider_page.dart';

/// NotifierProvider
final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});

final completedTodosProvider = Provider<List<Todo>>((ref) {
  /// 我们从todosProvider获取所有待办清单
  final todos = ref.watch(todosProvider);

  /// 我们只返回完成的待办事项
  return todos.where((todo) => todo.completed).toList();
});

/// AsyncNotifierProvider
final asyncTodosProvider = AsyncNotifierProvider<TodosAsyncNotifier, List<Todo>>(() {
  return TodosAsyncNotifier();
});

/// StateNotifierProvider
final stateTodosProvider = StateNotifierProvider<TodosStateNotifier, List<Todo>>((ref) {
  return TodosStateNotifier();
});

final _products = [
  Product(name: 'iPhone', price: 999),
  Product(name: 'cookie', price: 2),
  Product(name: 'ps5', price: 500),
];

final productsProvider = Provider<List<Product>>((ref) {
  final sortType = ref.watch(productSortTypeProvider);
  switch (sortType) {
    case ProductSortType.name:
      _products.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ProductSortType.price:
      _products.sort((a, b) => a.price.compareTo(b.price));
      break;
    default:
      break;
  }
  return _products;
});

/// StateProvider
final productSortTypeProvider = StateProvider<ProductSortType>(
  (ref) => ProductSortType.name,
);

final counterProvider = StateProvider<int>((ref) => 0);
