import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: CartService.cart,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(child: Text('Votre panier est vide'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(2)} EUR',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Supprimer',
                        onPressed: () => CartService.removeProduct(product.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<List<Product>>(
        valueListenable: CartService.cart,
        builder: (context, items, _) {
          final total = CartService.totalPrice(items);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${total.toStringAsFixed(2)} EUR',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
