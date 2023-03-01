import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/AsyncNotifierProvider/async_notifier_provider.dart';

class AsyncNotifierProviderPage extends ConsumerWidget {
  const AsyncNotifierProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(asyncTodosProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncNotifierProvider Demo'),
      ),
      body: asyncTodos.when(
        data: (todos) => ListView(
          children: [
            for (final todo in todos)
              CheckboxListTile(
                value: todo.completed,
                onChanged: (value) => ref.read(asyncTodosProvider.notifier).toggle(todo.id),
                title: Text(todo.description),
              ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
