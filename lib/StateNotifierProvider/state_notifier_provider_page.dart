import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/StateNotifierProvider/state_notifier_provider.dart';
import 'package:riverpod_example/model/todo.dart';

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(stateTodosProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider Demo'),
      ),
      body: ListView(
        children: [
          for (final todo in todos)
            CheckboxListTile(
              value: todo.completed,
              onChanged: (value) => ref.read(stateTodosProvider.notifier).toggle(todo.id),
              title: Text(todo.description),
            )
        ],
      ),
    );
  }
}
