import 'package:flutter/foundation.dart';

import '../models/product.dart';

/// Simple in-memory cart manager.
/// Swap this for real persistence (e.g., Firestore) later.
class CartService {
  CartService._();

  static final ValueNotifier<List<Product>> cart =
      ValueNotifier<List<Product>>(_mockCart);

  static void addProduct(Product product) {
    cart.value = [...cart.value, product];
  }

  static void removeProduct(String productId) {
    cart.value = cart.value.where((p) => p.id != productId).toList();
  }

  static double totalPrice(List<Product> items) {
    return items.fold(0, (sum, p) => sum + p.price);
  }

  // Initial mock data.
  static final List<Product> _mockCart = [
    Product(
      id: 'c1',
      title: 'T-shirt essentiel',
      category: 'Haut',
      size: 'L',
      brand: 'Basics',
      price: 19.90,
      imageUrl: 'https://picsum.photos/seed/cartshirt/300/300',
    ),
    Product(
      id: 'c2',
      title: 'Pantalon chino',
      category: 'Pantalon',
      size: '42',
      brand: 'UrbanFit',
      price: 49.90,
      imageUrl: 'https://picsum.photos/seed/cartpants/300/300',
    ),
  ];
}
