import 'dart:io';

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/cart_service.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  final Product product;

  void _addToCart(BuildContext context, Product product) {
    CartService.addProduct(product);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ajoute au panier')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produit'),
        leadingWidth: 90,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Retour'),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1.6,
                child: product.imageUrl.startsWith('http')
                    ? Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _DetailRow(label: 'Categorie', value: product.category),
            _DetailRow(label: 'Taille', value: product.size),
            _DetailRow(label: 'Marque', value: product.brand),
            const SizedBox(height: 8),
            Text(
              '${product.price.toStringAsFixed(2)} EUR',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _addToCart(context, product),
                child: const Text('Ajouter au panier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
