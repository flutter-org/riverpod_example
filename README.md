# 概念

## Providers

provider是一个封装了一部分状态的对象，并且能够监听其中的状态。

### 为什么要使用providers?

将一部分状态包裹在provider中:

- 允许在各种地方简单地访问所需的状态。 Provider可以完全取代各种编程模式，比如： 单例模式、服务定位器模式、依赖注入或 InheritedWidgets。
- 与其他状态组合很容易。 想要将多个对象合并成一个对象而感到苦恼? Provider自带了这个功能。
- 性能优化。 无论是筛选功能的widget还是缓存一个计算量比较大的状态， provider能够确保只有受状态变化影响的部分才会被重新计算。
- 提高你的应用程序的可测试性。 使用 provider， 你不需要复杂的 `setUp`/`tearDown` (配置/销毁) 的过程。 除此之外，在测试中，任何provider都可以覆盖不同的行为，这能够轻松地测试非常特殊的行为。
- 能够方便地集成一些高级的功能, 比如登录或下拉刷新.

### 创建一个provider

Provider有许多变体，但它们的工作方式都是一样的。

如下所示，最常见的使用方法是将它们声明为全局常量：

```dart
final myProvider = Provider((ref) {
  return MyValue();
});
```

> 备注
>
> 不要因为provider的功能全面而感到害怕。Provider是完全不可变的。 定义一个provider和定义一个函数一样简单，而且provider是可测试和可维护的。

这段代码由三部分组成:

- `final myProvider`, 声明myProvider这个变量。 这个变量我们将会用来读取其中的状态。 Provider应当一直是 `final`的。
- `Provider`, 我们决定使用的provider类型。 [Provider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/provider) 大多数provider类型的基础。 它暴露了一个永远不会改变的常量。 我们可以吧 [Provider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/provider) 换成 其他provider 比如：[StreamProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/stream_provider) 或 [StateNotifierProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/state_notifier_provider) 来改变其中状态的类型。
- 一个创建共享状态的函数。 那个函数会接收一个叫`ref`的对象作为参数。这个`ref`对象能够让我们在函数中读取其他的provider， 当provider中的状态需要销毁时执行一些操作等等。

provider中的函数返回的对象类型取决于使用provider类型。 比如一个 [Provider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/provider) 的函数中可以返回任意的对象。 再比如说[StreamProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/stream_provider)中的函数的返回值类型只能是[Stream](https://api.dart.dev/stable/2.8.4/dart-async/Stream-class.html)。

> 信息
>
> 你可以没有限制地声明各种provider。 与使用 `package:provider` 相反, [Riverpod](https://github.com/rrousselgit/riverpod) 允许创建多个相同类型且暴露不同状态的provider：
>
> ```dart
> final cityProvider = Provider((ref) => 'London');
> final countryProvider = Provider((ref) => 'England');
> ```
>
> 创建都是`String`类型的provider不会有任何问题。

### 不同类型的Provider

| Provider 类型                                                | 创建Provider的函数       | 使用场景                                           |
| ------------------------------------------------------------ | ------------------------ | -------------------------------------------------- |
| [Provider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/provider) | 返回任意类型             | 服务类 / 计算属性 (过滤的列表)                     |
| [StateProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/state_provider) | 返回任意类型             | 过滤条件/简单状态对象                              |
| [FutureProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/future_provider) | 返回任意类型的Future     | API调用的结果                                      |
| [StreamProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/stream_provider) | 返回任意类型的Stream     | API返回的Stream                                    |
| [StateNotifierProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/state_notifier_provider) | 返回StateNotifier的子类  | 一种复杂的状态对象，除了通过接口之外，它是不可变的 |
| [ChangeNotifierProvider](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ChangeNotifierProvider-class.html) | 返回ChangeNotifier的子类 | 需要可变的复杂状态对象                             |

> 警告
>
> 尽管所有的provider都有它的使用目的，由于 [不可变状态相关的问题](https://docs-v2.riverpod.dev/zh-Hans/docs/concepts/why_immutability) 的原因， 我们不推荐在较大型的应用程序中使用 [ChangeNotifierProvider](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ChangeNotifierProvider-class.html) 。 `flutter_riverpod` 中的 [ChangeNotifierProvider](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ChangeNotifierProvider-class.html) 提供了一个简单的方式来让你从 `package:provider` 迁移到 [riverpod](https://github.com/rrousselgit/riverpod) ， 这允许一些 flutter 上一些特定的用法比如与Navigator 2 package 集成。

### Provider 修饰符

所有的Provider都有一个内置的方式为不同的provider添加额外的功能。

它们可能会向`ref`对象添加额外的功能或改变provider的使用方式。 修饰符可以在所有provider上通过简单的命名构造器使用：

```dart
final myAutoDisposeProvider = StateProvider.autoDispose<int>((ref) => 0);
final myFamilyProvider = Provider.family<String, int>((ref, id) => '$id');
```



目前有两个修饰符可用:

- [`.autoDispose`](https://docs-v2.riverpod.dev/zh-Hans/docs/concepts/modifiers/auto_dispose)可以在状态不在被监听的情况下让provider自动销毁。
- [`.family`](https://docs-v2.riverpod.dev/zh-Hans/docs/concepts/modifiers/family)可以创建有外部参数的provider。

> 备注
>
> provider能一次使用多个修饰符:
>
> ```dart
> final userProvider = FutureProvider.autoDispose.family<User, int>((ref, userId) async {
>   return fetchUser(userId);
> });
> ```
