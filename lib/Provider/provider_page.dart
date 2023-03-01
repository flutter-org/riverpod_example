import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/Provider/provider.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final completedTodos = ref.watch(completedTodosProvider);

          /// TODO show the todos using a ListView/GridView/...
          return ListView(
            children: [
              for(final todo in completedTodos)
                Text(todo.description)
            ],
          );
        },
      ),
    );
  }
}
