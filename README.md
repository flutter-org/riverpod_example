# 1.Providers

provider是一个封装了一部分状态的对象，并且能够监听其中的状态。

## 1.1 为什么要使用providers?

将一部分状态包裹在provider中:

- 允许在各种地方简单地访问所需的状态。 Provider可以完全取代各种编程模式，比如： 单例模式、服务定位器模式、依赖注入或 InheritedWidgets。
- 与其他状态组合很容易。 想要将多个对象合并成一个对象而感到苦恼? Provider自带了这个功能。
- 性能优化。 无论是筛选功能的widget还是缓存一个计算量比较大的状态， provider能够确保只有受状态变化影响的部分才会被重新计算。
- 提高你的应用程序的可测试性。 使用 provider， 你不需要复杂的 `setUp`/`tearDown` (配置/销毁) 的过程。 除此之外，在测试中，任何provider都可以覆盖不同的行为，这能够轻松地测试非常特殊的行为。
- 能够方便地集成一些高级的功能, 比如登录或下拉刷新.

## 1.2 创建一个provider

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

## 1.3 不同类型的Provider

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

## 1.4 Provider 修饰符

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

# 2.读取 Provider

## 2.1 获取一个“ref”对象

首先，也是最重要的，在读取provider之前，我们需要获取一个“ref”对象。

这个对象能够让我们与provider交互，不管是来自widget还是其他provider。

### 2.1.1 从provider获取“ref”

所有provider都接收一个“ref”作为参数：

```dart
final valueProvider = Provider((ref) {
  // 使用ref获取其他provider
  final repository = ref.watch(repositoryProvider);
  return repository.get();
});
```

将此参数传递给provider暴露的值是安全的。

一个常见的用例是将provider的“ref”传递给`StateNotifier`

```dart
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(ref);
});

class Counter extends StateNotifier<int> {
  Counter(this.ref) : super(0);

  final Ref ref;

  void increment() {
    // Counter可以使用“ref”读取其他provider
    final repository = ref.read(repositoryProvider);
    repository.post('...');
  }
}
```

这样做允许`Counter`类读取provider。

### 2.1.2 从widget获取“ref”

Widget自然没有ref参数。但是 [Riverpod](https://github.com/rrousselgit/riverpod) 提供了多种从widget中获取ref的解决方案。

#### (1) 扩展ConsumerWidget而不是StatelessWidget

在widget树中获取ref的最常用方法是将 [StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) 替换为 [ConsumerWidget](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerWidget-class.html) 。

[ConsumerWidget](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerWidget-class.html) 在用法上与 [StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) 相同，唯一的区别是它在构建方法上有一个额外的参数:“ref”对象。

一个典型的 [ConsumerWidget](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerWidget-class.html) 如下所示:

```dart
class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用ref监听provider
    final counter = ref.watch(counterProvider);
    return Text('$counter');
  }
}
```

#### (2) 扩展ConsumerStatefulWidget+ConsumerState而不是StatefulWidget+State

与 [ConsumerWidget](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerWidget-class.html) 类似， [ConsumerStatefulWidget](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerState-class.html) 和 [ConsumerState](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerStatefulWidget-class.html) 等价于带有状态的StatefulWidget，区别在于状态中有一个“ref”对象。

这一次，“ref”没有作为构建方法的参数传递，而是作为 [ConsumerState](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerStatefulWidget-class.html) 对象的属性传递：

```dart
class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    // “ref” 可以在 StatefulWidget 的所有的生命周期内使用。
    ref.read(counterProvider);
  }

  @override
  Widget build(BuildContext context) {
    // 我们也可以在build函数中使用“ref”监听provider
    final counter = ref.watch(counterProvider);
    return Text('$counter');
  }
}
```

## 2.2 使用ref与provider交互

现在我们有了一个“ref”，我们可以开始使用它了。

“ref”有三种主要用法：

- 获取provider的值并监听更改，这样当该值发生更改时， 将重新构建订阅该值的widget或provider。
  这是使用 `ref.watch` 完成的
- 在provider上添加监听器，以执行诸如导航到新页面或每当provider更改时显示模态框等操作。
  这是使用 `ref.listen` 完成的。
- 在忽略更改的情况下获取provider的值。 当我们在诸如“on click”之类的事件中需要provider的值时很有用。
  这是使用 `ref.read` 完成的。

> 备注
>
> 尽可能使用 `ref.watch` 而不是 `ref.read` 或 `ref.listen` 来实现你的功能。 通过依赖 `ref.watch` ，你的应用变得既具有响应性又具有声明性，这使得项目会更易于维护。

### 2.2.1 使用 ref.watch 观察provider

Ref.watch在widget的`build`方法中或在provider的主体中使用，以使widget/provider监听provider：

例如，一个provider可以使用 `ref.watch` 将多个provider组合成一个新值。

筛选待办清单就是一个例子。我们可以有两个provider：

- `filterTypeProvider`，一个能够暴露当前过滤器类型(不显示，只显示完成的内容等等)的provider。
- `todosProvider`，暴露整个待办清单列表的provider。

通过 `ref.watch`，我们可以创建第三个provider， 它结合了这两个provider来创建一个过滤过的待办清单列表：

```dart
final filterTypeProvider = StateProvider<FilterType>((ref) => FilterType.none);
final todosProvider =
    StateNotifierProvider<TodoList, List<Todo>>((ref) => TodoList());

final filteredTodoListProvider = Provider((ref) {
  // 获取筛选器和待办清单列表
  final FilterType filter = ref.watch(filterTypeProvider);
  final List<Todo> todos = ref.watch(todosProvider);

  switch (filter) {
    case FilterType.completed:
      // 返回完成的待办清单
      return todos.where((todo) => todo.isCompleted).toList();
    case FilterType.none:
      // 返回所有的待办清单
      return todos;
  }
});
```

有了这段代码，`filteredTodoListProvider` 现在暴露了过滤后的清单列表。

如果筛选器或待办清单列表发生变化，筛选后的列表也会自动更新。 同时，如果过滤器和待办清单列表都没有改变，则不会重新计算那个列表。

类似地，widget可以使用ref.watch显示来自provider的内容， 并在内容发生变化时更新用户界面：

```dart
final counterProvider = StateProvider((ref) => 0);

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用ref监听provider
    final counter = ref.watch(counterProvider);

    return Text('$counter');
  }
}
```

这个代码段显示了一个widget，它监听了存储`count`的provider。 如果该`count`发生变化，widget将重新构建，UI将更新以显示新的值。

> 警告
>
> 像在 [ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html) 的 `onPressed` 中那样，`watch` 方法不应该被异步调用。 它也不应该在 `initState` 和其他 [State](https://api.flutter.dev/flutter/widgets/State-class.html) 的生命周期中使用。
>
> 在这种情况下，请考虑使用 `ref.read`。

### 2.2.2 使用ref.listen来响应provider的变化

与 `ref.watch` 类似，也可以使用ref.listen来观察一个provider。

它们之间的主要区别是，如果监听的provider发生更改， 使用 `ref.listen` 将调用自定义的函数，而不是重新构建widget/provider。

这对于在发生特定变化时执行操作很有用，例如在发生错误时显示snackbar。

`ref.listen` 方法需要两个位置参数，第一个是Provider，第二个是当状态改变时我们想要执行的回调函数。 当调用回调函数时将传递前一个状态的值和新状态的值。

`ref.listen` 方法可以在provider内部使用：

```dart
final anotherProvider = Provider((ref) {
  ref.listen<int>(counterProvider, (int? previousCount, int newCount) {
    print('The counter changed $newCount');
  });
  // ...
});
```

或者在widget的 `build` 方法中：

```dart
final counterProvider =
    StateNotifierProvider<Counter, int>((ref) => Counter(ref));

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int>(counterProvider, (int? previousCount, int newCount) {
      print('The counter changed $newCount');
    });

    return Container();
  }
}
```

> 警告
>
> 像在 [ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html) 的 `onPressed` 中那样，`listen` 方法不应该被异步调用。 它也不应该在 `initState` 和其他 [State](https://api.flutter.dev/flutter/widgets/State-class.html) 的生命周期中使用。

### 2.2.3 使用ref.read获取一个provider的状态

`ref.read` 是一种不监听provider状态的方法。

它通常在用户交互触发的函数中使用。 例如，我们可以使用 `ref.read` 在用户单击按钮时将计数器数值加1：

```dart
final counterProvider =
    StateNotifierProvider<Counter, int>((ref) => Counter(ref));

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 对“Counter”类调用“increment()”方法
          ref.read(counterProvider.notifier).increment();
        },
      ),
    );
  }
}
```



> 备注
>
> 你应该尽量避免使用 `ref.read` ，因为它不是响应式的。
>
> 它的存在是由于使用 `watch` 或 `listen` 会导致问题。如果可以，使用 `watch`/`listen` 更好，尤其是 `watch`。

**不要在build方法中使用 `ref.read`**

你可能会想使用 `ref.read` 来优化widget的性能：

```dart
final counterProvider = StateProvider((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  // 使用 “read” 忽略provider的更新
  final counter = ref.read(counterProvider.notifier);
  return ElevatedButton(
    onPressed: () => counter.state++,
    child: const Text('button'),
  );
}
```

但这样做是非常糟糕的，它可能会导致预料之外的bug。

以这种方式使用 `ref.read` 通常会让人觉得“provider暴露的值永远不会改变， 所以使用 `ref.read` 是安全的”。但问题是， 虽然现在的provider可能确实永远不会更新它的值，但你无法保证以后的值还是一样的。

应用往往会发生很多变更，假设在未来，以前从未改变的一个值将需要改变。 如果你使用 `ref.read`，当该值需要更改时，你必须遍历整个代码库将 `ref.read` 更改为 `ref.watch`， 这很容易出错，而且你很可能会忘记某些情况。

但如果一开始就使用 `ref.watch`，当你重构时遇到的问题就会更少。

***但是我想要用 `ref.read` 来减少小部件重新构建的次数\***

这个想法很好，但需要注意的是，使用 `ref.watch` 也可以达到完全相同的效果(减少重新构建的次数)。

provider提供了许多获取值的方法，同时也减少了重新构建的次数，你可以使用这些方法。

比如，不应该这样：

```dart
final counterProvider = StateProvider((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  StateController<int> counter = ref.read(counterProvider.notifier);
  return ElevatedButton(
    onPressed: () => counter.state++,
    child: const Text('button'),
  );
}
```

我们应该:

```dart
final counterProvider = StateProvider((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  StateController<int> counter = ref.watch(counterProvider.notifier);
  return ElevatedButton(
    onPressed: () => counter.state++,
    child: const Text('button'),
  );
}
```

这两段代码实现了相同的效果：当计数器增加时，我们的按钮也不会重新构建。

另一方面，第二种方法支持重置计数器。例如，应用的另一部分可以调用：

```dart
ref.refresh(counterProvider);
```

来重新创建 `Counter` 对象。

如果我们在这里使用 `ref.read`，我们的按钮仍将使用之前的 `StateController` 实例， 但实际上该实例已被丢弃，不应该再使用。 当我们正确使用 `ref.watch` 将重新构建按钮以使用新的 `Counter`实例

## 2.3 选择读取的方式

根据你想要监听的provider，你可能有多个可以监听的值。

比如，考虑以下 [StreamProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/stream_provider)：

```dart
final userProvider = StreamProvider<User>(...);
```

当读取这个 `userProvider` 时，你可以：

- 通过监听 `userProvider` 本身 同步读取当前状态：

  ```dart
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<User> user = ref.watch(userProvider);
  
    return user.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => const Text('Oops'),
      data: (user) => Text(user.name),
    );
  }
  ```

- 通过监听 `userProvider.stream` 获取关联的 [Stream](https://api.dart.dev/stable/2.13.4/dart-async/Stream-class.html)：

  ```dart
  Widget build(BuildContext context, WidgetRef ref) {
    Stream<User> user = ref.watch(userProvider.stream);
  }
  ```

- 通过监听 `userProvider.future`，获得一个解析最新值的 [Future](https://api.dart.dev/stable/2.13.4/dart-async/Future-class.html) ：

  ```dart
  Widget build(BuildContext context, WidgetRef ref) {
    Future<User> user = ref.watch(userProvider.future);
  }
  ```

不同的provider可能提供用法。
要了解更多信息，请阅读[API 参考](https://pub.dev/documentation/riverpod/latest/riverpod/riverpod-library.html)来获取每个provider的文档。

## 2.4 使用“select”来过滤重建内容

与读取provider相关的最后一个特性是能够减少widget/provider从 `ref.watch` 重新构建的次数， 或者减少 `ref.listen` 执行函数的频率。

记住，这一点很重要，因为默认情况下，监听provider将监听整个对象状态。 但有时widget/provider可能只关心某些属性的更改，而不是整个对象。

比如说，一个provider可能暴露一个 `User` 对象：

```dart
abstract class User {
  String get name;
  int get age;
}
```

但是widget可能只使用用户名：

```dart
Widget build(BuildContext context, WidgetRef ref) {
  User user = ref.watch(userProvider);
  return Text(user.name);
}
```

如果我们简单地使用 `ref.watch`，这将在用户年龄(`age`)发生变化时重新构建widget。

解决方案是使用 `select` 显式地告诉Riverpod我们只想监听 `User` 的 `name` 属性。

更新后的代码如下:

```dart
Widget build(BuildContext context, WidgetRef ref) {
  String name = ref.watch(userProvider.select((user) => user.name));
  return Text(name);
}
```

通过使用 `select`，我们可以指定一个返回我们所关心的属性的函数。

每当 `User` 发生变化时，Riverpod将调用该函数并比较以前和新的结果。 如果它们是不同的(例如当名称更改时)，Riverpod将重新构建widget。

当然了，如果它们相等(例如当年龄改变时)，Riverpod将不会重建widget。

> 信息
>
> 也可以 `select` 和 `ref.listen` 结合使用：
>
> ```dart
> ref.listen<String>(
>   userProvider.select((user) => user.name),
>   (String? previousName, String newName) {
>     print('The user name changed $newName');
>   }
> );
> ```
>
> 这样做只会在名称更改时调用监听器。

> 提示
>
> 你不需要返回对象的属性。任何可以使用==的值都可以工作。举个例子：
>
> ```dart
> final label = ref.watch(userProvider.select((user) => 'Mr ${user.name}'));
> ```
