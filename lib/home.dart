import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 我们创建了一个 "provider", 这里它存储了一个值 (这里是 "Hello world")。
/// 通过使用provider，我们能够重写或模拟这个暴露的值
final helloWorldProvider = Provider((_) => 'Hello world');

/// 这里我们使用Rivderpod提供的 "ConsumerWidget" 而不是flutter自带的 "StatelessWidget"。
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(value),
      ),
    );
  }
}
