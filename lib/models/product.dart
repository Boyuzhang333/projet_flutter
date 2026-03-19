class Product {
  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.size,
    required this.brand,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String category;
  final String size;
  final String brand;
  final double price;
  final String imageUrl;
}
