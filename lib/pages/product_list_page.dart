import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final List<Product> _mockProducts = const [
    Product(
      id: '1',
      title: 'Sneakers Urbaines',
      size: '42',
      price: 79.99,
      imageUrl: 'https://picsum.photos/seed/sneakers/300/300',
    ),
    Product(
      id: '2',
      title: 'Veste en Jean',
      size: 'M',
      price: 59.90,
      imageUrl: 'https://picsum.photos/seed/jacket/300/300',
    ),
    Product(
      id: '3',
      title: 'Sac à Dos Minimal',
      size: 'Unique',
      price: 39.50,
      imageUrl: 'https://picsum.photos/seed/backpack/300/300',
    ),
    Product(
      id: '4',
      title: 'Montre Classique',
      size: '40mm',
      price: 129.00,
      imageUrl: 'https://picsum.photos/seed/watch/300/300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acheter'),
      ),
      body: ListView.builder(
        itemCount: _mockProducts.length,
        itemBuilder: (context, index) {
          final product = _mockProducts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(product.title),
              subtitle: Text('Taille : ${product.size}'),
              trailing: Text(
                '${product.price.toStringAsFixed(2)} €',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Acheter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
