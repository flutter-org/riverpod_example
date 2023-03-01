import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_example/widgets/pages/async_provider_page.dart';
import 'package:riverpod_example/widgets/pages/provider_page.dart';
import 'package:riverpod_example/home.dart';
import 'package:riverpod_example/widgets/pages/state_notifier_provider_page.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/provider',
      builder: (context, state) => const ProviderPage(),
    ),
    GoRoute(
      path: '/async',
      builder: (context, state) => const AsyncProviderPage(),
    ),
    GoRoute(
      path: '/state',
      builder: (context, state) => const StateNotifierProviderPage(),
    ),
  ],
);

void main() {
  runApp(
    // 为了让widget能够读取到provider，我们需要在整个应用外面套上一个
    // 名为 "ProviderScope"的widget。
    // 我们的这些provider会在这里保存。
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
