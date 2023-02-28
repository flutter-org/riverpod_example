import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/provider/riverpod.dart';
import 'package:riverpod_example/widgets/async_todo_list_view.dart';
import 'package:riverpod_example/widgets/todo_list_view.dart';

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
          return const AsyncTodoListView();
        },
      ),
    );
  }
}
