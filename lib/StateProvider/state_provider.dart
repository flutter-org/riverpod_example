import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/StateProvider/product.dart';
import 'package:riverpod_example/StateProvider/product_sort_type.dart';

final _products = [
  Product(name: 'iPhone', price: 999),
  Product(name: 'cookie', price: 2),
  Product(name: 'ps5', price: 500),
];

final productsProvider = Provider<List<Product>>((ref) {
  final sortType = ref.watch(productSortTypeProvider);
  switch (sortType) {
    case ProductSortType.name:
      _products.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ProductSortType.price:
      _products.sort((a, b) => a.price.compareTo(b.price));
      break;
    default:
      break;
  }
  return _products;
});

/// StateProvider
final productSortTypeProvider = StateProvider<ProductSortType>(
  (ref) => ProductSortType.name,
);

final counterProvider = StateProvider<int>((ref) => 0);
