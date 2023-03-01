import 'package:flutter/material.dart';
import 'package:riverpod_example/widgets/state_todo_list_view.dart';

class StateNotifierProviderPage extends StatelessWidget {
  const StateNotifierProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider Demo'),
      ),
      body: const StateTodoListView(),
    );
  }
}
