import 'package:flutter/foundation.dart';

import '../models/product.dart';

/// Temporary in-memory catalog provider.
/// Replace with real backend/Firebase implementation later.
class ProductService {
  const ProductService._();

  static final List<Product> _products = [
    Product(
      id: '1',
      title: 'Sneakers urbaines',
      category: 'Chaussures',
      size: '42',
      brand: 'Stride',
      price: 79.99,
      imageUrl: 'https://picsum.photos/seed/sneakers/300/300',
    ),
    Product(
      id: '2',
      title: 'Veste en jean',
      category: 'Haut',
      size: 'M',
      brand: 'Denim Co.',
      price: 59.90,
      imageUrl: 'https://picsum.photos/seed/jacket/300/300',
    ),
    Product(
      id: '3',
      title: 'Sac a dos minimal',
      category: 'Accessoire',
      size: 'Unique',
      brand: 'Nord',
      price: 39.50,
      imageUrl: 'https://picsum.photos/seed/backpack/300/300',
    ),
    Product(
      id: '4',
      title: 'Montre classique',
      category: 'Accessoire',
      size: '40mm',
      brand: 'Helios',
      price: 129.00,
      imageUrl: 'https://picsum.photos/seed/watch/300/300',
    ),
  ];

  static List<Product> fetchProducts() {
    debugPrint('Fetching mock products');
    return List<Product>.unmodifiable(_products);
  }

  static Future<void> addProduct(Product product) async {
    // Simulate async persistence.
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _products.add(product);
    debugPrint('Product added: ${product.title}');
  }
}
