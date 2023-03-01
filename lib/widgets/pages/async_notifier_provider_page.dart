import 'package:flutter/material.dart';
import 'package:riverpod_example/widgets/async_todo_list_view.dart';

class AsyncNotifierProviderPage extends StatelessWidget {
  const AsyncNotifierProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncNotifierProvider Demo'),
      ),
      body: const AsyncTodoListView(),
    );
  }
}
