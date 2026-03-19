import 'dart:io';

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';
import 'profile_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late final List<Product> _products;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _products = ProductService.fetchProducts();
  }

  void _onNavTap(int index) {
    if (index == 1) {
      setState(() => _selectedIndex = index);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CartPage()),
      ).then((_) {
        // Restore highlight to "Acheter" when returning.
        if (mounted) setState(() => _selectedIndex = 0);
      });
    } else if (index == 2) {
      setState(() => _selectedIndex = index);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const ProfilePage()))
          .then((_) {
        if (mounted) setState(() => _selectedIndex = 0);
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acheter'),
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _ProductImageThumb(imageUrl: product.imageUrl),
                    ),
                    title: Text(product.title),
                    subtitle: Text('Taille : ${product.size}'),
                    trailing: Text(
                      '${product.price.toStringAsFixed(2)} EUR',
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
            )
          : Center(
              child: Text(
                _selectedIndex == 1 ? 'Panier (a venir)' : 'Profil (a venir)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onNavTap,
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

class _ProductImageThumb extends StatelessWidget {
  const _ProductImageThumb({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(imageUrl),
      width: 64,
      height: 64,
      fit: BoxFit.cover,
    );
  }
}
