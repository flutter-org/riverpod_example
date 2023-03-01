import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_example/AsyncNotifierProvider/async_notifier_provider_page.dart';
import 'package:riverpod_example/NotifierProvider/notifier_provider_page.dart';
import 'package:riverpod_example/Provider/provider_page.dart';
import 'package:riverpod_example/home.dart';
import 'package:riverpod_example/StateNotifierProvider/state_notifier_provider_page.dart';
import 'package:riverpod_example/StateProvider/state_provider_page.dart';
import 'package:riverpod_example/provider_observer.dart';

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
      path: '/notifier',
      builder: (context, state) => const NotifierProviderPage(),
    ),
    GoRoute(
      path: '/async',
      builder: (context, state) => const AsyncNotifierProviderPage(),
    ),
    GoRoute(
      path: '/state_notifier',
      builder: (context, state) => const StateNotifierProviderPage(),
    ),
    GoRoute(
      path: '/state',
      builder: (context, state) => const StateProviderPage(),
    ),
  ],
);

void main() {
  runApp(
    // 为了让widget能够读取到provider，我们需要在整个应用外面套上一个
    // 名为 "ProviderScope"的widget。
    // 我们的这些provider会在这里保存。
    ProviderScope(
      observers: [
        Logger(),
      ],
      child: const MyApp(),
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
