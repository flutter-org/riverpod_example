import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/todo.dart';
import 'package:riverpod_example/provider/riverpod.dart';

class StateTodoListView extends ConsumerWidget {
  const StateTodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(stateTodosProvider);
    return ListView(
      children: [
        for (final todo in todos)
          CheckboxListTile(
            value: todo.completed,
            onChanged: (value) => ref.read(stateTodosProvider.notifier).toggle(todo.id),
            title: Text(todo.description),
          )
      ],
    );
  }
}
