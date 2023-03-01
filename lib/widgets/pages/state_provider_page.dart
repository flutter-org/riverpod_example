import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/provider/riverpod.dart';

enum ProductSortType {
  name,
  price,
}

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider Demo'),
        actions: [
          DropdownButton<ProductSortType>(
            dropdownColor: Colors.blue,
            value: ref.watch(productSortTypeProvider),
            onChanged: (value) => ref.read(productSortTypeProvider.notifier).state = value!,
            items: const [
              DropdownMenuItem(
                value: ProductSortType.name,
                child: Icon(Icons.sort_by_alpha),
              ),
              DropdownMenuItem(
                value: ProductSortType.price,
                child: Icon(Icons.sort),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Text('counter:${ref.watch(counterProvider)}'),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('${product.price} \$'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          /// update
          ref.read(counterProvider.notifier).update((state) => state + 1);
        },
      ),
    );
  }
}
